# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :tutor_id 
      t.integer :student_id
      t.string :subject 
      t.datetime :starting_date_and_time 
      t.datetime :ending_date_and_time 
      t.timestamps
    end
  end
end 

rails g resource Appointment tutor:references student:references subject:string starting_date_and_time:datetime ending_date_and_time:datetime 