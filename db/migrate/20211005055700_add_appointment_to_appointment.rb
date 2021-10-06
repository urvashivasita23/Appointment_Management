class AddAppointmentToAppointment < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :appointment, :datetime
  end
end
