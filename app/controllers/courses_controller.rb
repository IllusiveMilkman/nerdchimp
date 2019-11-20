class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @courses = policy_scope(Course.order(created_at: :desc))
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    if user_signed_in?
      authorize @course
    else
      redirect_to new_users_registration_path
    end
    @course = Course.new(course_params)
    if @course.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def destroy
    authorize @course
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to course_path(@course)
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :url, :provider, :category, :duration)
  end
end
