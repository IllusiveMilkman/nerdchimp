class UsersController < ApplicationController
  before_action :find_user, except: :persist

  def show
    authorize @user
    @paths = @user.paths
    @usercourses = UserCourse.where(user: current_user)
  end

  def edit
    authorize @user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(params[:id])
    authorize @user
  end

  def persist
    p "im here..................................................."
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo, :slug, :email)
  end
end
