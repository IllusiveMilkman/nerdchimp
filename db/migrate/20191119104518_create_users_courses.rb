class CreateUsersCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|
      t.float :course_tracker
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
