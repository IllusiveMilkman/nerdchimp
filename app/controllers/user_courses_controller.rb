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

  # method to add existing course from catalog to user library
  def add_course
    @course = Course.find(params[:course_id])
    current_user.courses << @course
    respond_to do |format|
      format.js { flash[:notice] = "Course successfully added!" }
    end
  end

  def update
  end

  def destroy
  end
end
