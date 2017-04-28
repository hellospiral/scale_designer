class ScalesController < ApplicationController

  def index
    @scales = Scale.all
  end

  def show
    if params[:id]
      @scale = Scale.find(params[:id])
    else
      unless @scale = Scale.find_by(name: 'Sandbox Scale')
        @scale = Scale.create(name: 'Sandbox Scale')
        @scale.notes.create(frequency: 150)
      end
    end
  end

  def new
    @scale = Scale.new
  end

  def create
    if current_user
      @scale = current_user.scales.new(scale_params)
      if @scale.save
        flash[:notice] = "Scale successfully added!"
        respond_to do |format|
          format.html {redirect_to scale_path(@scale)}
          format.js
        end
      else
        flash[:alert] = "Scale did not save! Please try again"
        render :new
      end
    else
      @scale = Scale.new(scale_params)
      if @scale.save
        flash[:notice] = "Scale successfully added!"
        respond_to do |format|
          format.html {redirect_to scale_path(@scale)}
          format.js
        end
      else
        flash[:alert] = "Scale did not save! Please try again"
        render :new
      end
    end
  end

  def edit
    @scale = Scale.find(params[:id])
  end

  def update
    @scale= Scale.find(params[:id])
    if @scale.update(scale_params)
      flash[:notice] = "Scale successfully updated!"
      respond_to do |format|
        format.html {redirect_to scale_path(@scale)}
        format.js
      end
    else
      flash[:alert] = "Scale did not update! Please try again"
      render :edit
    end
  end

  def destroy
    @scale = Scale.find(params[:id])
    @scale.destroy
    flash[:notice] = "Scale successfully deleted!"
    redirect_to scales_path
  end

  private
  def scale_params
    params.require(:scale).permit(:name)
  end
end
