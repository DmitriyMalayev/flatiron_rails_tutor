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

`Client Side vs. Server Side Saving`
Client Side => In a cookie 
Server Side => Persisted to DB 


OAuth Flow 
Knowing 4 Requests 

`If we want to make tutor not selectable. Note, this will break some functionality of form partial.` 
  <% if appointment.tutor_id %>
    <%= f.label :tutor_id, "Tutor" %>
    <%= f.hidden_field :tutor_id %>
    <%= appointment.tutor.name %>
  <% else %>
    <%= f.label :tutor_id, "Tutor Name" %>
    <%= f.collection_select(:tutor_id, Tutor.all, :id, :name %>
  <% end %>


rails g migration addOauthColumnsToUsers full_name:string avatar_url:string uid:string   `does it need to be full name??` 


Implement avatar_url and full_name to sign up form 


`bundle add dotenv-rails` This adds the dovenv rails gem 
Make sure to move this file from the bottom the the development test group in the GemFile 
