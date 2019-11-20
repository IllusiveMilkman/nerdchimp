class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :url, uniqueness: true
  
  # validates :provider, presence: true
  # validates :category, presence: true
  # validates :duration, presence: true

  has_many :users, through: :user_courses
end
