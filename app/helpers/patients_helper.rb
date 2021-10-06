# frozen_string_literal: true

# Patient_helper
module PatientsHelper
  def twolatest_careteams(patient)
    patient.appointments.order(appointment: :desc).limit(2)
  end
end
