class User < ApplicationRecord
  has_many :userCourses, dependent: :destroy
  has_many :UsersCoursesPaths, through: :userCourses, dependent: :destroy
  has_many :Paths, through: :UsersCoursesPaths

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  extend FriendlyId
  # before_validation :generate_slug

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :slug, uniqueness: true
  friendly_id :slug_candidates, use: :slugged

  def full_name
    "#{first_name} #{last_name}"
  end

  def slug_candidates
    [:full_name, [:full_name, :id_for_slug]]
    # could also use [:full)_name, :id] which would add the user id for uniqueness.
  end

  def id_for_slug
    generated_slug = normalize_friendly_id(full_name)
    # p generated_slug
    # The following will search for any existing entries that start with the generated_slug.
    things = self.class.where("slug LIKE ?", "#{generated_slug}%")
    # things = things.where.not(id: id) unless new_record?
    things.count + 1
  end
end
