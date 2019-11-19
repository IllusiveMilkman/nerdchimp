class PathsController < ApplicationController
  before_action :find_user
  before_action :find_path, except: [:create, :new]

  def index
    @path = Path.all
  end

  def create
    @path = Path.create!(path_param)
    redirect_to user_path(@user)
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
    params.require(:path).permit(:title)
  end

  def find_user
    @user = User.friendly.find(params[:user_id])
  end

  def find_path
    @path = Path.find(params[:path_id])
  end
end
