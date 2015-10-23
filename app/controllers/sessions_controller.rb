class SessionsController < ApplicationController
  before_action :user_check,only: [:new,:create]
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      flash[:success] = "Ok"
      redirect_back_or user
    else
      flash.now[:error] = "Invalid email/password pair"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def user_check
    redirect_to current_user unless current_user.nil?
  end
end