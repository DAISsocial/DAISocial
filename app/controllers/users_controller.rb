class UsersController < ApplicationController
  before_action :signed_in_user,only: [:edit,:update,:destroy]
  before_action :correct_user,only: [:edit,:update]
  before_action :admin_user,only: :destroy
  before_action :user_check,only: [:new, :create]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page],per_page: 2)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile was updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user != current_user
      user.destroy
      flash[:success] = "User deleted"
    end
    redirect_to users_path
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url,notice: "Please,sign in" unless signed_in?
    end
  end

  def user_check
    redirect_to current_user unless current_user.nil?
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
