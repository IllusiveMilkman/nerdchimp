class UsersCoursesController < ApplicationController
  def index
    @userscourses = UserCourse.all
    UserCourse.new
  end

  def create

  end
  def update
  end

  def destroy
  end
end
