class UsersController < ApplicationController
  before_action :find_user, except: :persist

  def show
    authorize @user
    @paths = @user.paths
    @usercourses = UserCourse.where(user: current_user)
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

    # Create an array of the new posistions
    new_path_array = id_string.split(",").map! { |e| e.to_i }
    puts "New order array: #{new_path_array}"

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
        new_course = UsersCoursesPath.new
        new_course.user_course_id = course
        new_course.path_id = path_id
        new_course.save
      end
    end

    # Now check if there are deleted items
    deleted_items_array = current_path_array - new_path_array;
    puts "Courses to Delete: #{deleted_items_array}"

    unless deleted_items_array.empty?
      deleted_items_array.each do |course|
        console.log("course to delete: #{course}")
        console.log("courses are deleted under the UsersCoursesPathsController\#destory method")
      end
    end

    # for debugging only:
    updated_current_path_array = UsersCoursesPath.where(path_id: path_id).pluck(:user_course_id) # Will return an array of instances
    puts "Now the courses in database are: #{updated_current_path_array}"

    # Since all the items are now present, we can compare positions.
    # If there's no change to the other item positions, move on, else update position.
    new_path_array.each_with_index { |course, index|
      puts "#{course} => #{index}"
      update_position(path_id, course, index)
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
    # puts "path_id: #{path_id}"
    # puts "course: #{course}"
    # puts "position: #{position}"
    path_item = UsersCoursesPath.find_by(path_id: path_id, user_course_id: course)
    path_item.position = position
    path_item.save
  end
end
