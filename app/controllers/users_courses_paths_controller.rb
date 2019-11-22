class UsersCoursesPathsController < ApplicationController
  def index
    @path_courses = UsersCoursesPath.all
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
    # Debug stuff
    # p params
    # path_id = params[:id]
    # puts "path_id: #{path_id}"
    # course_id = params[:course_id]
    # puts "course_id: #{course_id}"

    # comment until event listener is done.
    # path_course_to_delete = UsersCoursesPath.find_by(path_id: params[:id], user_course_id: params[:course_id])
    # path_course_to_delete.destroy
  end
end
