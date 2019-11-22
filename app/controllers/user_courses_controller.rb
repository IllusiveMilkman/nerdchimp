class UserCoursesController < ApplicationController
  before_action :set_usercourse, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token, only: %i[update]

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
    byebug
    if @usercourse.update(usercourse_params)
      render json: @usercourse, status: :ok
    else
      render json: @usercourse.errors, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_usercourse
    @usercourse = UserCourse.find(params[:id])
  end

  def usercourse_params
    params.require(:usercourse).permit(:course_tracker)
  end
end
