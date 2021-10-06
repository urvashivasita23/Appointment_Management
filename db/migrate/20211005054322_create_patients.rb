class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :medical_record
      t.string :test_results
      t.string :medications

      t.timestamps
    end
  end
end
