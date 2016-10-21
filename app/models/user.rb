class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :user_courses
  has_many :courses
  has_many :courses, through: :user_courses
  has_many :user_subjects
  has_many :subjects, through: :user_subjects

  enum role: {trainee: 0, supervisor: 1, admin: 2}
  mount_uploader :avatar_url, AvatarUrlUploader

  validates :name, presence: true, length: {maximum: 50}

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  scope :recent, ->{order created_at: :desc}
  scope :member_course, -> course do
    joins("INNER JOIN user_courses ON users.id = user_courses.user_id")
      .where "user_courses.course_id = ? ", course.id
  end

end
