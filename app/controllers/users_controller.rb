class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    @user_courses = UserCourse.inprogress_by_user(@user)
    @course_finish = UserCourse.by_user_finish(@user.id)
  end
end
