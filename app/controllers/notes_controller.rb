class NotesController < ApplicationController
  def new
    @scale = Scale.find(params[:scale_id])
    @note = @scale.notes.new
  end

  def create
    @scale = Scale.find(params[:scale_id])
    if params[:frequencies] == ""
      flash[:alert] = "You must enter at least one frequency"
      return redirect_to new_scale_note_path(@scale)
    else
      @scale.create_note(params)
      respond_to do |format|
        format.html {redirect_to scale_path(@scale)}
        format.js
      end
    end
  end

  def edit
    @note = Note.find(params[:id])
    @scale = Scale.find(params[:scale_id])
  end

  def update
    @scale = Scale.find(params[:scale_id])
    @note = @scale.notes.find(params[:id])
    if params[:transposition]
      @note.transpose(params)
      flash[:notice] = "Note successfully updated!"
      respond_to do |format|
        format.html {redirect_to scale_path(@scale)}
        format.js
      end
    elsif @note.update(note_params)
      flash[:notice] = "Note successfully updated!"
      respond_to do |format|
        format.html {redirect_to scale_path(@scale)}
        format.js
      end
    else
      flash[:alert] = "Note did not update! Please try again"
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @scale = @note.scale
    @note.destroy
    flash[:notice] = "Note successfully deleted!"
    respond_to do |format|
      format.html {redirect_to scale_path(@scale)}
      format.js
    end
  end

  def show
  end

  private
  def note_params
    params.require(:note).permit(:frequency, :transposition)
  end
end
