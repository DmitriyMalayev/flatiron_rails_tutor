class AppointmentsController < ApplicationController # app/controllers/appointments_controller.rb
  before_action :authenticate_user!  #A user must be authenticated to view appointments. #Checks if a User is logged in before any method runs.
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]  #set @appointment for the following list for current_user

  # The Controller Renders The View
  def index
    @student = current_user.students.find_by_id(params[:student_id])  #All of the students that belong to the current user
    @tutor = Tutor.find_by_id(params[:tutor_id])  #A tutor is not directly related to a user
    if @student #If a student exists we want to render a student's appointments
      @appointments = @student.appointments  #We can use @student because it belongs to the user
    elsif @tutor
      @appointments = current_user.appointments.by_tutor(@tutor)  #All of the appointments with a specific tutor
    else
      @appointments = current_user.appointments   #If it's neither show all of the appointments
    end
    filter_options   #upcoming, past, recent, longest ago filtering options
  end

  # .find => raises an ActiveRecord::RecordNotFound exception when the record doesn't exist
  # .find_by(id: id) => Will return nil

  # Every time we make a request that matches the index route. @appointments is set to all of the appointments that belong to the current user's appointments. If we hit a nested route, we only want the appointments that belong to the student.

  # How do we know in the index action if we're on a nested route or not?  If the request that matched this action was made to the nested route or not the nested route.  ??

  def show
    # Handled by :set_appointment
    # Needs to be present because it's connected to the show template which is rendered
  end

  def new
    @student = current_user.students.find_by_id(params[:student_id])
    # We find out if we're on a nested route under students or tutors for the new appointment.
    # We check if there is a student that we're getting from the URL?

    @tutor = Tutor.find_by_id(params[:tutor_id])  #We're checking if there is a Tutor that we're getting from the URL
    if @student
      @appointment = @student.appointments.build
      # We call build on the association. If this saves (it does) then the foreign key for a student_id is assigned to the student's id ??
      # If there is a student present we make it belong to the student
    elsif @tutor
      @appointment = @tutor.appointments.build
      # We call build on the association. If this saves (it does) then the foreign key for a tutor_id is assigned to the tutor's id ??
      # If there is a tutor present we make the appointment belong to the tutor.
    else
      @appointment = Appointment.new
      # If it's neither one we just make a new appointment.
    end
    filter_options  #private method for filtering results
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointment_path(@appointment)  #show form
    else
      render :new
    end
    # An Appointment does not belong to a User  (no direct relationship)
    # An Appointment belongs_to a Tutor and Student

  end

  def edit
    # Handled by :set_appointment
    # Needs to be present because it's connected to the edit template which is rendered
  end

  def update
    if @appointment.update(appointment_params) # update also saves
      redirect_to appointment_path(@appointment) # if it updates and saves goes to show page
    else
      :edit
    end
  end

  def destroy
    @appointment.destroy  #Finds and Destroys
    redirect_to appointments_path  #Index
  end

  private

  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
    #Runs before any other methods (other than authenticate_user!) and sets the following for the current user
  end

  def filter_options
    if params[:filter_by_time] == "upcoming"
      @appointments = @appointments.upcoming
    elsif params[:filter_by_time] == "past"
      @appointments = @appointments.past
    end

    if params[:sort] == "most_recent"
      @appointments = @appointments.most_recent
    elsif params[:sort] == "longest_ago"
      @appointments = @appointments.longest_ago
    end
  end

  def appointment_params #Must have appointment. Can have the other stuff.
    params.require(:appointment).permit(:tutor_id, :student_id, :subject, :starting_date_and_time, :ending_date_and_time)
  end
end
