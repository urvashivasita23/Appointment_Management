class AddDepartmentToAppointment < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :department, :string
  end
end
