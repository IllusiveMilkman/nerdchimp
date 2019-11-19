class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :users_courses_paths
end
