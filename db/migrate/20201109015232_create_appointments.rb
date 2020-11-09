class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :tutor, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.string :subject
      t.datetime :starting_date_and_time
      t.datetime :ending_date_and_time

      t.timestamps
    end
  end
end
