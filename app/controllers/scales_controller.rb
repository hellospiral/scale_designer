class ScalesController < ApplicationController
  def index
    @scales = Scale.all
  end

  def show
    @scale = Scale.find(params[:id])
  end

  def new
    @scale = Scale.new
  end

  def create
    @scale = Scale.new(scale_params)
    if @scale.save
      flash[:notice] = "Scale successfully added!"
      redirect_to scales_path
    else
      flash[:alert] = "Scale did not save! Please try again"
      render :new
    end
  end

  def edit
    @scale = Scale.find(params[:id])
  end

  def update
    @scale= Scale.find(params[:id])
    if @scale.update(scale_params)
      flash[:notice] = "Scale successfully updated!"
      redirect_to scales_path
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
