class Admin::ScenesController < ApplicationController

  def index
    @scene = Scene.new
    @scenes = Scene.all
  end

  def create
    @scene = Scene.new(scene_params)
    if @scene.save
      redirect_to scenes_path
    else
      puts @scene.errors.full_messages
      @scenes = Scene.all
      render :index
    end
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])
    if @scene.update(scene_params)
      redirect_to scenes_path
    else
      render :edit
    end
  end

  def destroy
    @scene = Scene.find(params[:id])
    @scene.destroy
    redirect_to scenes_path
  end

  private

  def scene_params
    params.require(:scene).permit(:name)
  end

end
