# frozen_string_literal: true

# Doctor_controller
class DoctorsController < ApplicationController
  def index
    @doctors = if !params[:specialty].blank?
                 Doctor.by_specialty(params[:specialty])
               else
                 Doctor.all
               end
    @users = User.doctors.where(['firstname LIKE ?', "%#{params[:search]}%"]).page(params[:page]).per(10)
  end

  # admin privilege
  # patient can only view limited Doctor's information
  def show
    @doctor = Doctor.find_by(id: params[:id])
  end
end
