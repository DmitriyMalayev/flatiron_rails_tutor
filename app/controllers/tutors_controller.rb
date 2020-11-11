class TutorsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_tutor, only: [:show, :edit, :update, :destroy]

    def index
        # Make sure the student in the URL belongs to the current user 
        # Because we do not want to show a list of tutors if it doesn't belong to the current user 
        @tutors = Tutor.all 
    end

    def show
        
    end

    def new
        @tutor = Tutor.new 
    end

    def create
        @tutor = Tutor.new(tutor_params)
        if @tutor.save 
            redirect_to tutor_path(@tutor)
        else 
            render :new 
        end 
    end

    private 

    def set_tutor
        @tutor = Tutor.find(params[:id]) 
    end 


    def tutor_params
        params.require(:tutor).permit(:name, :phone_number, :email, :years_of_experience) 
    end 
end


