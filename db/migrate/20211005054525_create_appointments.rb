class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.string :medical_record
      t.string :test_results
      t.string :treatment_plans
      t.string :prescriptions
      t.string :billing

      t.timestamps
    end
  end
end
