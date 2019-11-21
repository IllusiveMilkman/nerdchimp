class Course < ApplicationRecord
  include PgSearch::Model

  validates :title, presence: true
  validates :description, presence: true
  validates :url, uniqueness: true

  # validates :provider, presence: true
  # validates :category, presence: true
  # validates :duration, presence: true

  has_many :users, through: :user_courses

  pg_search_scope :global_search,
    against: [:title, :description],
    using: {
      tsearch: { prefix: true }
    }
end
