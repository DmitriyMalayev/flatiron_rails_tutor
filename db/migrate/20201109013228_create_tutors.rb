class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.integer :years_of_experience
      t.datetime :starting_date_and_time 
      t.datetime :ending_date_and_time 

      t.timestamps
    end
  end
end
