class AddDefaultValueInUserCourses < ActiveRecord::Migration[5.2]
  def change
    UserCourse.update_all(course_tracker: 0)
    change_column :user_courses, :course_tracker, :float, :default => 0
  end
end
