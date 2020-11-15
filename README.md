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






The controller generator is expecting parameters in the form of generate controller ControllerName action1 action2. 
Let's make a Greetings controller with an action of hello, which will say something nice to us.

`rails generate controller Greetings hello` 
  create  app/controllers/greetings_controller.rb
  route  get 'greetings/hello'
  invoke  erb
  create    app/views/greetings
  create    app/views/greetings/hello.html.erb
  invoke  test_unit
  create    test/controllers/greetings_controller_test.rb
  invoke  helper
  create    app/helpers/greetings_helper.rb
  invoke    test_unit
  invoke  assets
  invoke    scss
  create      app/assets/stylesheets/greetings.scss 

`rails server` 
This command launches a web server named Puma which comes bundled with Rails. 
You'll use this any time you want to access your application through a web browser.


`rails new commandsapp`
  create
  create  README.md
  create  Rakefile
  create  config.ru
  create  .gitignore
  create  Gemfile
  create  app
  ...
  create  tmp/cache
  ...
    run  bundle install


`rails console`
The console command lets you interact with your Rails application from the command line. On the underside, rails console uses IRB, so if you've ever used it, you'll be right at home. This is useful for testing out quick ideas with code and changing data server-side without touching the website.

`rails db:migrate`  
The most common commands of the db: rails namespace are migrate and create, and it will pay off to try out all of the migration rails commands (up, down, redo, reset). rails db:version is useful when troubleshooting, telling you the current version of the database.

`rails routes` 
This will list all of your defined routes, which is useful for tracking down routing problems in your app, or giving you a good overview of the URLs in an app you're trying to get familiar with.`

`Google Login` 
<%- if devise_mapping.omniauthable? %>
  <%- resource_class.omniauth_providers.each do |provider| %>
    <%= link_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(resource_name, provider) %><br />
  <% end %>
<% end %>


 