class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :users_courses_paths
  # ------------------------------------
  attr_accessor :user_url
  validate :user_url_error
  def user_url_error
    if UserCourse.exists?(user_id: user_id, course_id: course_id)
      errors.add(:user_url, 'you already have this course in your library')
    end
  end
  # attr accessor allowes us to use the url in the user_course controller
  # the method makes a custom error message for the form when the combination already exists
  # -----------------
  validates :user_id, presence: true, uniqueness: { scope: :course_id }
  validates :course_id, presence: true, uniqueness: { scope: :user_id }
end
