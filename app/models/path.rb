class Path < ApplicationRecord
  has_many :users_courses_paths
  has_many :user_courses, through: :users_courses_paths
end
