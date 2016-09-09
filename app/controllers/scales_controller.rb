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
      redirect_to scales_path
    else
      render :new
    end
  end

  private
  def scale_params
    params.require(:scale).permit(:name)
  end
end
