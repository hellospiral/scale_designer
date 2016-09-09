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
      render :new
    end
  end

private
  def note_params
    params.require(:note).permit(:frequency)
  end
end
