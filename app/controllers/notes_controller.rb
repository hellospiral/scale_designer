class NotesController < ApplicationController
  def new
    @scale = Scale.find(params[:scale_id])
    @note = @scale.notes.new
  end

  def create
    @scale = Scale.find(params[:scale_id])
    @note = @scale.notes.new(note_params)
    if @note.save
      flash[:notice] = "Note successfully added!"
      redirect_to scale_path(@note.scale)
    else
      flash[:alert] = "Note was not added! Please try again"
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
    @scale = Scale.find(params[:scale_id])
  end

  def update
    @note = Note.find(params[:id])
    @scale = @note.scale
    if @note.update(note_params)
      flash[:notice] = "Note successfully updated!"
      redirect_to scale_path(@note.scale)
    else
      flash[:alert] = "Note did not update! Please try again"
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = "Note successfully deleted!"
    redirect_to scale_path(@note.scale)
  end

  private
  def note_params
    params.require(:note).permit(:frequency)
  end
end
