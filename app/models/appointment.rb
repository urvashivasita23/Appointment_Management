# frozen_string_literal: true

# Appointment_model
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  def doctor_specialty
    doctor ? doctor.specialty : nil
  end

  def doctor_fullname
    doctor ? doctor.fullname : nil
  end

  def doctor_hospital
    doctor ? doctor.hospital : nil
  end

  def patient_fullname
    patient ? patient.fullname : nil
  end

  def start_time
    appointment
  end
end
