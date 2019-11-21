class AddPositionToUsersCoursesPaths < ActiveRecord::Migration[5.2]
  def change
    # This migration was created from acts_as_list documentation
    add_column :users_courses_paths, :position, :integer
  end
end
