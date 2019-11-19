class UserCoursesController < ApplicationController
  def index
    @userscourses = UserCourse.all
    UserCourse.new
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @usercourse = UserCourse.new
  end

  def create
    @user = User.friendly.find(params[:user_id])
    @usercourse = UserCourse.new
    @usercourse.user_id = @user.id
    @usercourse.course_id = params[:user_course]['course_id']

    if @usercourse.save!
      redirect_to user_path(@user)
    end
  end

  def update
  end

  def destroy
  end


end
