class UsersController < ApplicationController
  before_action :find_user, except: :persist

  def show
    authorize @user
    @paths = @user.paths
    @path = Path.new
    @usercourses = UserCourse.where(user: @user).order(created_at: :desc)
    @usercourse = UserCourse.new # mo needs for search bar in
    # @coursebananas = UserCourse.where(user: @user, course_tracker: user.courses.duration)
    @coursebananas = 0
    UserCourse.where(user: @user).each do |usercourse|
      @coursebananas += 1 if usercourse.course.duration == usercourse.course_tracker.to_i
    end
  end

  def edit
    authorize @user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(params[:id])
    authorize @user
  end

  def persist
    p "persist method ..................................................."
    # Declare variables required
    id_string = params[:id_array]
    path_id = params[:path_id].to_i
    puts "Parameters: #{params}"

    # Find the user based on the current path
    user = User.find(Path.find(path_id).user_id)

    # Create an array of the new posistions - based on course id
    new_path_array = id_string.split(",").map! { |e| e.to_i }
    puts "New order array: #{new_path_array}"

    # Create an array of the new posistions - based on library id
    new_path_array.map! { |course_no|
      UserCourse.find_by(user_id: current_user, course_id: course_no).id
    }
    puts "Updated new order array (in Library id form): #{new_path_array}"

    # Get array from current path
    current_path_array = UsersCoursesPath.where(path_id: path_id).pluck(:user_course_id) # Will return an array of instances
    puts "Array currently on db: #{current_path_array}"
    # p current_path_array.length
    # p current_path_array.class

    # If there's a new item, add it and then add the position to that item as well
    new_courses_to_add = new_path_array - current_path_array
    puts "New courses to add: #{new_courses_to_add}"

    unless new_courses_to_add.empty?
      new_courses_to_add.each do |course|
        puts "course to add: #{course}"
        new_course = UsersCoursesPath.new
        new_course.user_course = UserCourse.find(course)
        new_course.path_id = path_id

        # byebug

        # for debugging only
        puts "new course object: #{new_course}"
        puts "User: #{current_user}"
        puts "user_course: #{new_course.user_course}"
        puts "path_id: #{new_course.path_id}"
        puts "position: #{new_course.position}"

        if new_course.save!
          puts "Course #{course} saved"
        else
          p "Errors: #{new_course.errors.messages}"
        end
      end
    end

    # for debugging only:
    updated_current_path_array = UsersCoursesPath.where(path_id: path_id).pluck(:user_course_id) # Will return an array of instances
    puts "After SAVING - the courses in database are: #{updated_current_path_array}"

    # Now check if there are deleted items
    deleted_items_array = current_path_array - new_path_array;
    puts "Courses to Delete: #{deleted_items_array}"

    unless deleted_items_array.empty?
      deleted_items_array.each do |course|
        puts "course to delete: #{course}"
        puts "courses are deleted under the UsersCoursesPathsController\#destory method"
      end
    end

    # for debugging only:
    updated_current_path_array = UsersCoursesPath.where(path_id: path_id).pluck(:user_course_id) # Will return an array of instances
    puts "After DELETING - the courses in database are: #{updated_current_path_array}"

    # Since all the items are now present, we can compare positions.
    # If there's no change to the other item positions, move on, else update position.
    new_path_array.each_with_index { |course, index|
      puts "#{course} => #{index}"
      user_course_id = UserCourse.find(course).id
      update_position(path_id, user_course_id, index)
    }
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo, :slug, :email)
  end

  def update_position(path_id, course, position)
    puts "Update position method =========="
    puts "path_id: #{path_id}"
    puts "course: #{course}"
    puts "position: #{position}"
    path_item = UsersCoursesPath.find_by(path_id: path_id, user_course_id: course)
    path_item.position = position
    path_item.save
  end
end
