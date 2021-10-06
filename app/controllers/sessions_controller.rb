# frozen_string_literal: true

# Password_Controller

class SessionsController < ApplicationController
  skip_before_action :logged_in?, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      if @user.admin == true
        redirect_to admin_users_path
      elsif @user.admin == false && current_doctor
        redirect_to doc_users_path
      else
        current_patient
        redirect_to patient_path(current_patient)
      end
    else
      flash[:alert] = 'Please try again.'
      render :new
    end
  end

  # user log out
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logging out.'
    redirect_to '/'
  end
end
