class Course < ApplicationRecord
  belongs_to :user
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  accepts_nested_attributes_for :course_subjects, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:subject_id].blank? ||
      attributes[:subject_id] == 0}
  accepts_nested_attributes_for :user_courses, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:user_id].blank? ||
      attributes[:user_id] == 0}

  enum status: {pending: 0, started: 1, finished: 2}

  after_create :send_mail_finish_after_two_days

  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 10}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_subjects

  def build_course_subjects add_subjects = {}
    Subject.all.each do |subject|
      unless add_subjects.include? subject
        self.course_subjects.build subject_id: subject.id
      end
    end
  end

  def build_user_courses add_users = Array.new
    if self.started?
      @users = self.is_deactive_course
    else
      @users = User.all
    end
    @users.each do |user|
      unless add_users.include? user
        self.user_courses.build user_id: user.id
      end
    end
  end

  private
  def validate_subjects
    count = course_subjects.select{|course_subject| !course_subject._destroy}.count
    if count < Settings.course_subject_quanlity
      errors.add :subjects, I18n.t("admin.courses.subject_quanlity_error")
    end
  end

  def send_mail_finish_after_two_days
    SupervisorWorker.perform_at (end_date - 2.days),
      SupervisorWorker::FINISH, self.id
  end
end
