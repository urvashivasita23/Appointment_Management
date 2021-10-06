# frozen_string_literal: true

# Application_Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :error, :notice, :alert
  before_action :logged_in?
  skip_before_action :logged_in?, only: [:home]
  helper_method :current_user, :current_patient, :current_doctor, :logged_in?

  def home; end

  def logged_in?
    !!session[:user_id]
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_patient
    @current_patient ||= Patient.find_by(user_id: session[:user_id])
  end

  def current_doctor
    @current_doctor ||= Doctor.find_by(user_id: session[:user_id])
  end
end
