class Path < ApplicationRecord
  belongs_to :user
  has_many :users_courses_paths, dependent: :destroy
  has_many :user_courses, through: :users_courses_paths, class_name: 'UserCourse'
  has_many :courses, through: :user_courses
  validates :title, length: { minimum: 1 }

  def total_tracker
    user_courses.sum(&:course_tracker)
  end

  def total_duration
    courses.sum(&:duration).to_i
  end

  def progress
    total_duration.zero? && total_tracker.zero? ? 0 : ((total_tracker / total_duration) * 100).to_i
  end
end
