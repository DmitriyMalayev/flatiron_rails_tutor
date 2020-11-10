 class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :student

  validates :starting_date_and_time, :ending_date_and_time, :subject, presence: true
  validate :tutor_conflict, :student_conflict, if: :starts_before_it_ends?  
  validate :ends_after_it_starts 

  def tutor_conflict 
    starting = self.starting_date_and_time
    ending = self.ending_date_and_time
    conflict = tutor.appointments.any? do |appointment|
      other_start = appointment.starting_date_and_time
      other_end = appointment.ending_date_and_time 
      other_start < ending && ending < other_end || other_start < starting && starting < other_end 
    end
    if conflict 
      errors.add[:tutor, "Conflicting Appointment Present"]
    end 
  end
   

  def student_conflict 
    starting = self.starting_date_and_time
    ending = self.ending_date_and_time
    conflict = student.appointments.any? do |appointment|
      other_start = appointment.starting_date_and_time
      other_end = appointment.ending_date_and_time 

      other_start < ending && ending < other_end || other_start < starting && starting < other_end 
    end
    if conflict 
      errors.add[:student, "Conflicting Appointment Present"]
    end    
  end
  
  def ends_after_it_starts
    if !starts_before_it_ends? 
      errors.add(:starting_date_and_time, "must be before the ending date and time")
    end
  end

  def starts_before_it_ends? 
    starting < ending
  end 
  
  



  
  def tutor_name 
    self.tutor.name  
  end 

  def patient_name 
    self.patient.name  
  end 
end 