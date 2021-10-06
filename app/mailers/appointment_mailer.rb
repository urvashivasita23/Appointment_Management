# frozen_string_literal: true

# Appointment_mailer
class AppointmentMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def reschedule
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
