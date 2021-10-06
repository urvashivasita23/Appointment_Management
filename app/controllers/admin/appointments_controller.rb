# frozen_string_literal: true

# Appointment_controller
class Admin::AppointmentsController < ApplicationController
  before_action :set_appointment

  def edit; end

  def update
    @appointment.update(appointment_params)

    if @appointment.save
      render :edit
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    if @user
      @appointment.destroy
      flash[:notice] = 'Appointment deleted.'
      redirect_to admin_user_path(@user)
    else
      flash[:notice] = 'Invalid URL path.'
      redirect_to admin_users_path
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find_by(id: params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:department, :appointment, :test_results, :treatment_plans,
                                        :prescriptions, :billing)
  end
end
