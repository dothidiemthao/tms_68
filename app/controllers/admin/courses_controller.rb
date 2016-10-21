class Admin::CoursesController < ApplicationController
  layout "admin_application"
  before_action :authenticate_user!
  before_action :verify_admin
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "admin.courses.action_success"
      redirect_to admin_courses_path
    else
      @course.build_course_subjects
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date,
      :status, :user_id, course_subjects_attributes: [:id, :subject_id,
        :_destroy]
  end
end
