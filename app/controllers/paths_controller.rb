class PathsController < ApplicationController
  before_action :find_user
  before_action :find_path, except: [:create, :new, :update]

  def index
    @path = Path.all
  end

  def create
    @path = Path.new(path_param)
    @path.user_id = @user.id
    @path.save!
    redirect_to user_path(@user)
  end

  def new
    @path = Path.new
  end

  def show
  end

  def edit
    @user = User.friendly.find(params[:user_id])
    @path = Path.find(params[:id])
  end

  def update
    @path = Path.find(params[:id])
    @path.update(path_param)

    if @path.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @path.user_id = current_user.id
    @path.destroy
    redirect_to user_path(@user)
  end

  private

  def path_param
    params.require(:path).permit(:title, :user_id)
  end

  def find_user
    @user = User.friendly.find(params[:user_id])
  end

  def find_path
    @path = Path.find(params[:id])
  end
end
