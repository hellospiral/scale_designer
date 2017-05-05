class ScalesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create]

  def index
    @scales = Scale.active
  end

  def show
    @scale = Scale.find(params[:id])
  end

  def new
    @scale = Scale.new
  end

  def create
    if current_user
      @scale = current_user.scales.new(name: 'New Scale ' + Scale.count.to_s)
      flash[:notice] = "Scale successfully added!"
    else
      @scale = find_or_create_starter_scale
    end
    if @scale.save
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

  def find_or_create_starter_scale
    @scale = Scale.find_by(user_id: nil, notes_count: 1)
    if @scale == nil
      @scale = Scale.create(name: 'Sandbox Scale ' + Scale.count.to_s)
    end
    return @scale
  end

end
