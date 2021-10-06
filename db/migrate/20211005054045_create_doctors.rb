class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :specialty
      t.string :hospital
      t.integer :reg_no

      t.timestamps
    end
  end
end
