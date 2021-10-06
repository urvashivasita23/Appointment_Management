# frozen_string_literal: true

# Doctors_controller
class Doc::DoctorsController < ApplicationController
  before_action :set_doctor

  def edit; end

  def update
    @doctor.update(doctor_params)

    if @doctor.save
      redirect_to doc_users_path(@doctor.user)
    else
      render :edit
    end
  end

  def show
    @doctor = Doctor.find_by(id: params[:id])
  end

  private

  def set_doctor
    @doctor = Doctor.find_by(id: params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:user_id, :specialty, :hospital, :reg_no)
  end
end
