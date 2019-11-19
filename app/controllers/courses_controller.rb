class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    # authorize @course
  end

  def create
    @course = Course.new(course_params)
    # authorize @course
    if @course.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def destroy
    # authorize @course
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to course_path(@course)
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :url, :provider, :category, :duration)
  end
end
