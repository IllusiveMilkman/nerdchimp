class Path < ApplicationRecord
  belongs_to :user
  has_many :users_courses_paths
  has_many :user_courses, through: :users_courses_paths, class_name: 'UserCourse'

  # scope :getcourse, -> { joins(:users_courses_paths).left_outer_joins(:user_courses) }
end
