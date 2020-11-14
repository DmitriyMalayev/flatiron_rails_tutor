# app/controllers/students_controller.rb
class StudentsController < ApplicationController
    before_action :authenticate_user! #Checks if a User is logged in before any method runs 
    before_action :set_student, only: [:show, :edit, :update, :destroy] #set @student for the following list for current_user    

    def index
        @students = current_user.students   
        #All of the students that belong to the current user 
    end

    def show
        # Handled by :set_student 
        # Needs to be present because it's connected to the show template which is rendered   
    end 

    def new
        @student = Student.new  
        # Make a new instance of the Student class for the new form 
    end

    def create
        @student = current_user.students.build(student_params) 
        # We call .build on students for the current user. This will make the new student belong_to the current_user. 
        # The student's user_id will be current_user.id.  The alternative @student = Student.new(student_params) will not have the same result.  
        if @student.save 
            redirect_to student_path(@student)  #show ?? 
        else
            render :new 
        end 
    end

    def edit
        @student = current_user.students.find(params[:id]) 
    end

    def update
        if @student.update(student_params)
            redirect_to student_path(@student)
        else 
            render :edit 
        end 
    end

    def destroy
       @student.destroy  #Finds and Destroys. 
       redirect_to students_path  
    #If an unauthorized user tries to delete a student that they don't have access to they will be redirected because of the set_student method 
    end

    private 

    def set_student
        @student = current_user.students.find(params[:id]) 
        # If the current_user is nil we will be redirected to the home route. 
        # We are preventing anyone from viewing, editing, updating or deleting something they have not created. 
        # This works in conjunction with the rescue method. ?? 
    end 

    def student_params
        params.require(:student).permit(:name, :phone_number, :email) 
    end 
end

# OTHER EXAMPLES 
# params.require(:patient).permit(:name, :allergy_ids [], guardian_attributes: [:name, :phone_number])  
# This will allow you to call the nested attributes method, because it's whitelisted 
# The empty [] is used if you have checkboxes 

# Roles:
#   User
#   Admin

# Generated methods:
#   authenticate_user!  # Signs user in or redirect
#   authenticate_admin! # Signs admin in or redirect
#   user_signed_in?     # Checks whether there is a user signed in or not
#   admin_signed_in?    # Checks whether there is an admin signed in or not
#   current_user        # Current signed in user
#   current_admin       # Current signed in admin
#   user_session        # Session data available only to the user scope
#   admin_session       # Session data available only to the admin scope

# Use:
#   before_action :authenticate_user!  # Tell devise to use :user map
#   before_action :authenticate_admin! # Tell devise to use :admin map



# <%= render :partial => "account" %>

# This means there is already an instance variable called @account for the partial and you pass it to the partial.

# <%= render :partial => "account", :locals => { :account => @buyer } %>

# This means you pass a local instance variable called @buyer to the account partial and the variable in the account partial is called @account. I.e., the hash { :account => @buyer } for :locals is just used for passing the local variable to the partial. You can also use the keyword as in the same way:

# <%= render :partial => "contract", :as => :agreement

# which is the same as:

# <%= render :partial => "contract", :locals => { :agreement => @contract }