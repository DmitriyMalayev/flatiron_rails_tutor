class TutorsController < ApplicationController # app/controllers/tutors_controller.rb
  before_action :authenticate_user!  #Checks if a User is logged in before any method runs
  before_action :set_tutor, only: [:show, :edit, :update, :destroy] #set @tutor for the following list for current_user

  def index
    @tutors = Tutor.all
    # Discuss with Dakota??
    # Make sure the student in the URL belongs to the current user
    # Because we do not want to show a list of tutors if it doesn't belong to the current user
  end

  def show
    # Handled by :set_tutor
    # Needs to be present because it's connected to the show template which is rendered
  end

  def new
    @tutor = Tutor.new
    #Make a new instance for new form
  end

  def create #User can create a Tutor but cannot edit or delete an exiting tutor??
    @tutor = Tutor.new(tutor_params)  # Make a new instance and fill it in with the tutor_params
    if @tutor.save #checks if it saves
      redirect_to tutor_path(@tutor)  #show page
    else
      render :new  #new page
    end
  end

  private

  def set_tutor
    @tutor = Tutor.find(params[:id]) #Find and assign the tutor to @tutor
  end

  def tutor_params #must have // can have
    params.require(:tutor).permit(:name, :phone_number, :email, :years_of_experience)
  end
end
