# frozen_string_literal: true

# Appointment_Controller
class AppointmentsController < ApplicationController
  def index
    if params[:patient_id]
      @patient = Patient.find_by(id: params[:patient_id])
      if @patient.nil? || @patient != current_patient
        flash[:alert] = 'Error URL path.'
        redirect_to patient_path(current_patient)
      else
        @appointments = @patient.appointments
      end
    else
      @appointments = Appointment.all
    end
  end

  def new
    @appointment = Appointment.new
    @patient = Patient.find_by(id: params[:patient_id])

    if params['specialty'] == ''
      flash[:error] = 'You must select a specialty.'
      redirect_to select_specialty_path
    elsif @patient.nil? || @patient != current_patient
      flash[:alert] = 'Error URL path.'
      redirect_to select_specialty_path
    else
      @doctors = Doctor.by_specialty(params['specialty'])
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if params['appointment']['doctor_id'] == '' || params['appointment']['appointment'] == ''
      flash[:error] = 'Please select doctor and appointment time.'
      redirect_to select_specialty_path
    else
      @appointment = current_patient.appointments.build(appointment_params)
      @appointment.doctor = Doctor.find_by(id: params['appointment']['doctor_id'])

      if @appointment.save
        AppointmentMailer.with(user: @user).reschedule.deliver_later

        redirect_to patient_appointment_path(current_patient, @appointment)
      else
        redirect_to patient_path(current_patient)
      end
    end
  end

  def show
    if params[:patient_id]
      @patient = Patient.find_by(id: params[:patient_id])
      if @patient.nil? || @patient != current_patient
        flash[:alert] = 'Error URL path.'
        redirect_to patient_path(current_patient)
      else
        @appointment = @patient.appointments.find_by(id: params[:id])

        if @appointment.nil?
          flash[:alert] = 'Appointment not found.'
          redirect_to patient_appointments_path(@patient)
        end
      end
    else
      @appointment = Appointment.find(params[:id])
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:department, :appointment, :test_results, :treatment_plans,
                                        :prescriptions, :billing)
  end
end
