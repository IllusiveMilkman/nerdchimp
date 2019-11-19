class UsersCoursesPath < ApplicationRecord
  belongs_to :user_course
  belongs_to :path
end
