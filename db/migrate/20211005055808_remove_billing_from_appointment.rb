class RemoveBillingFromAppointment < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :billing, :string
  end
end
