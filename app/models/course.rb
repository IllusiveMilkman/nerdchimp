class Course < ApplicationRecord
  validates :title, presence: true
  validates :decription, presence: true
  validates :url, uniqueness: true
  validates :provider, uniqueness: true
  validates :category, uniqueness: true
  validates :duration, uniqueness: true
end
