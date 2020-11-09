class StudentsController < ApplicationController
    before_action :authenticate_user! 
    def index
        @students = current_user.students 
    end
end
