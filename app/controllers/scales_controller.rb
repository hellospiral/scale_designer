class ScalesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @scales = Scale.all
  end

  def show
    if params[:id]
      @scale = Scale.find(params[:id])
    elsif current_user && current_user.scales.any?
      @scale = current_user.scales.last
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
      @scale = current_user.scales.new(name: 'New Scale ' + Scale.count.to_s)
    else
      @scale = Scale.new(name: 'New Scale ' + Scale.count.to_s)
    end
    if @scale.save
      @scale.notes.create(frequency: 150)
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
