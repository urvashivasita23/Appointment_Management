# frozen_string_literal: true

# Password_Controller
class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    PasswordMailer.with(user: @user).reset.deliver_now if @user.present?
    redirect_to root_path, notice: 'If the account was found, an email will be sent.'
  end

  def edit
    @user = User.find_signed(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to password_reset_path, alert: 'Token Expired, Try Again.'
  end

  def update
    @user = User.find_signed(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to signin_path, notice: 'Password was reset successfully, Please Sign in.'
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
