class UserCoursesController < ApplicationController
  def index
    @userscourses = policy_scope(UserCourse.all)

  end

  def new
    @user = User.friendly.find(params[:user_id])
    @usercourse = UserCourse.new
    authorize @usercourse
    @render_form_for_manual_input = false
  end

  def create

    @user = current_user
    @usercourse = UserCourse.new
    authorize @usercourse
    if Course.where(url: params[:user_course][:user_url]) != [] # if statement to check if url already exists in db
      # the course already exists and we find the instance of that course
      @course = Course.find_by(url: params[:user_course][:user_url])
      # adding course id  to new user course
      @usercourse.course_id = @course.id
      # adding user id to new user course
      @usercourse.user_id = @user.id
      if @usercourse.save
        redirect_to user_path(@user)
      else
        @usercourse.user_url = params[:user_course][:user_url]
        render :new # this happens when @usercourse could not be saved because it already exists
      end
    else
      # scraper
      require "open-uri" # install gem later ?
      require "nokogiri"
      begin
        html_content = open(params[:user_course][:user_url], 'User-Agent' => 'firefox').read
        doc = Nokogiri::HTML(html_content)
        contents = doc.search("meta[property='og:title'], meta[property='og:description']").map { |n| n['content'] } # scraping for title and discription
        course = Course.create(title: contents[0], description: contents[1], url: params[:user_course][:user_url]) # creating a new course with url title and description
        if course.save # can that course be saved ? validations... are all parameters given?
          @course = Course.last # getting the last course out of database so we have an id
          @usercourse.course_id = @course.id
          @usercourse.user_id = @user.id
          @usercourse.save! # finally saving the usercourse in library
          redirect_to user_path(@user) # user show
        end
      rescue # rescues us from errors
        @render_form_for_manual_input = true # the 'open' creates a 403 with udemy or no website input form needs to be displayed
        render :new
      end
    end
  end

  def update
  end

  def destroy
  end
end
