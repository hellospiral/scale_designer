class NotesController < ApplicationController
  

  def new
    @scale = Scale.find(params[:scale_id])
    @note = @scale.notes.new
  end

  def create
    @scale = Scale.find(params[:scale_id])
    if params[:frequencies] == ""
      flash[:alert] = "You must enter at least one frequency"
      redirect_to new_scale_note_path(@scale)
    else
      notes_array = params[:frequencies].split(',')
      notes_array.each do |note|
        note.strip
        @scale.notes.create(frequency: note)
      end

      respond_to do |format|
        format.html {redirect_to scale_path(@scale)}
        format.js { flash[:notice] = "Notes sucessfully added!" }
      end
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

  private
  def note_params
    params.require(:note).permit(:frequency)
  end
end
