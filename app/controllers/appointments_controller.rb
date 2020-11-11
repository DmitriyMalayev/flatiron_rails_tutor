class AppointmentsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_appointment, only: [:show, :edit, :update, :destroy] 

    def index
        @student = current_user.students.find_by_id(params[:student_id])
        @tutor = Tutor.find_by_id(params[:tutor_id])
        if @student
            @appointments = @student.appointments
        elsif @tutor
            @appointments = current_user.appointments.by_tutor(@tutor)
        else 
            @appointments = current_user.appointments  
        end  
        filter_options 
    end

    def show

    end

    def new
        @student = current_user.students.find_by_id(params[:student_id])
        @tutor = Tutor.find_by_id(params[:tutor_id]) 
        if @student 
            @appointment = @student.appointments.build 
        elsif @tutor 
            @appointment = @tutor.appointments.build 
        else 
            @appointment = Appointment.new
        end          
    end

    def create
        @appointment = Appointment.new(appointment_params)
        if @appointment.save 
            redirect_to appointment_path(@appointment)
        else 
            render :new 
        end  
    end

    def edit
        
    end

    def update
        if @appointment.update(appointment_params) 
            redirect_to appointment_path(@appointment)
        else 
            :edit 
        end 
    end

    def destroy
        @appointment.destroy 
        redirect_to appointments_path
    end

    private 

    def set_appointment
        @appointment = current_user.appointments.find(params[:id]) 
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


    def appointment_params
        params.require(:appointment).permit(:tutor_id, :student_id, :subject, :starting_date_and_time, :ending_date_and_time) 
    end 

end

  
#   create_table "appointments", force: :cascade do |t|
#     t.integer "tutor_id", null: false
#     t.integer "student_id", null: false
#     t.string "subject"
#     t.datetime "starting_date_and_time"
#     t.datetime "ending_date_and_time"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.index ["student_id"], name: "index_appointments_on_student_id"
#     t.index ["tutor_id"], name: "index_appointments_on_tutor_id"
#   end

