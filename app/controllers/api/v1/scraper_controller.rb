require "open-uri"
require "nokogiri"

class Api::V1::ScraperController < Api::V1::BaseController
  def index
    user_url = params[:user_url]
    @user = current_user
    # @usercourse = UserCourse.new

    if Course.where(url: user_url) != [] # if statement to check if url already exists in db
      # the course already exists and we find the instance of that course
      @course = Course.find_by(url: user_url)
      # adding course id  to new user course
      #UserCourse.new(user: @user, course: @course)
      # @usercourse.course = @course
      # adding user id to new user course
      # @usercourse.user_id = @user.id
      UserCourse.create(user: @user, course: @course)
      #   redirect_to user_path(@user)
      # else
      #   @usercourse.user_url = user_url
      #   render :new # this happens when @usercourse could not be saved because it already exists
      # end
    else
      begin
        html_content = open(user_url, 'User-Agent' => 'firefox').read
        doc = Nokogiri::HTML(html_content)
        contents = doc.search("meta[property='og:title'], meta[property='og:description']").map { |n| n['content'] } # scraping for title and discription
        @course = Course.new(title: contents[0], description: contents[1], url: user_url) # creating a new course with url title and description
      rescue # rescues us from errors
        @course = Course.new(title: "", description: "", url: user_url)
      end
    end
  end
end
