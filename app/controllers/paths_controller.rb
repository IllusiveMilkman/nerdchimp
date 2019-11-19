class PathsController < ApplicationController
  before_action :find_param, except: [:create, :new]

  def create
    @path = Path.create!(path_param)
  end

  def new
    @path = Path.new
  end

  def show
  end

  def update
    @path.update
  end

  def destroy
    @path.destroy
  end

  private

  def path_param
    params.require(:path_id).permit(:title)
  end

  def find_param
    @path = Path.find(params[:path_id])
  end
end
