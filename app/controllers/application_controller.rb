class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller? 

    protected 

    def configure_permitted_parameters
        devise_parameter.sanitizer.permit(:sign_up, keys: [:username])  
    end  
end 



# class CreateStudents < ActiveRecord::Migration[6.0]
#   def change
#     create_table :students do |t|
#       t.string :name
#       t.string :phone_number
#       t.string :email 

#       t.timestamps
#     end
#   end
# end