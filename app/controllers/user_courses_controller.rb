class UserCoursesController < ApplicationController
  def index
    @userscourses = policy_scope(UserCourse.all)

  end

  def new
    @user = User.friendly.find(params[:user_id])
    @usercourse = UserCourse.new
    authorize @usercourse
    @course = Course.new
  end

  def create
    p = params[:user_course]
    course = Course.new(title: p[:title], url: p[:url], description: p[:description], duration: p[:duration], provider: p[:provider], category: p[:category])
    course.save
    usercourse = UserCourse.new(user: current_user, course: Course.last)
    authorize usercourse
    if usercourse.save
      redirect_to user_path(current_user)
    end
  end

  def update
  end

  def destroy
  end
end
