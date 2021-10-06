class AddBillingToAppointment < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :billing, :decimal
  end
end
