class UsersCoursesPathsController < ApplicationController
  def index
    @path_courses = UsersCoursesPath.all
  end

  def show
    @user = User.friendly.find(params[:user_id])
    @path = @user.paths.where(id: params[:id])
    @usercourses = UserCourse.where(user: current_user).order(created_at: :desc)

    @coursebananas = 0
    UserCourse.where(user: @user).each do |usercourse|
      puts usercourse
      @coursebananas += 1 if usercourse.course.duration == usercourse.course_tracker.to_i
    end
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
    # need to authenticate user to ensure that only current_user can destroy one of their own courses.

    # Debug stuff
    p params
    path_id = params[:id]
    puts "path_id: #{path_id}"

    user_id = User.find(Path.find(path_id).user_id).id
    puts "user_id: #{user_id}"

    course_id = params[:course_id]
    puts "course_id: #{course_id}"

    user_course_id = UserCourse.find_by(user_id: user_id, course_id: course_id).id
    puts "users_courses_path_id = #{user_course_id}"

    path_course_to_delete = UsersCoursesPath.find_by(path_id: path_id, user_course_id: user_course_id)
    path_course_to_delete.destroy
  end
end
