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
    id_string = params[:id_array]
    path_id = params[:path_id].to_i
    p id_string
    p path_id
    id_array = id_string.split(",").map! { |e| e.to_i }
    p id_array
    id_array.each_with_index { |course, index|
      puts "#{course} => #{index}"
      update_position(path_id, course, index)
    }
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo, :slug, :email)
  end

  def update_position(path_id, course, position)
    # puts "path_id: #{path_id}"
    # puts "course: #{course}"
    # puts "position: #{position}"
    path_item = UsersCoursesPath.find_by(path_id: path_id, user_course_id: course)
    path_item.position = position
    path_item.save
  end
end
