class AppointmentsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_appointment, only: [:show, :edit, :update, :destroy] 

    def index
        @appointments = current_user.appointments 
    end

    def show

    end

    def new
        @appointment = Appointment.new         
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

