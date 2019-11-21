class CreateUsersCoursesPaths < ActiveRecord::Migration[5.2]
  def change
    create_table :users_courses_paths do |t|
      # t.string :course_position # removing due to acts_as_list gem
      t.references :user_course, foreign_key: true
      t.references :path, foreign_key: true

      t.timestamps
    end
  end
end
