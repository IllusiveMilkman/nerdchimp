class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :paths, through: :users_courses_paths
end
