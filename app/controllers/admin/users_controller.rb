class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  load_and_authorize_resource

  def index
    @users = User.trainee if current_user.supervisor?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.index.delete_success"
    else
      flash[:danger] = t "users.index.delete_fail"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
