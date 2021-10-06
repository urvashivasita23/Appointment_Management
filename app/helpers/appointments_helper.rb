# frozen_string_literal: true

# Appointment_helper
module AppointmentsHelper
  def time(appointment)
    appointment.strftime('%l:%M %p')
  end

  def date_time(appointment)
    appointment.strftime('%B %d, %Y at %l:%M %p')
  end

  def appointment_time(appointment)
    appointment.appointment.strftime('%A, %B %d, %Y at %l:%M %p')
  end
end
