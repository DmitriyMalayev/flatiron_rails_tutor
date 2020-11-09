class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :student

  validates :subject, :starting_date_and_time, :ending_date_and_time, presence: true
  validate :tutor_conflict, :student_conflict, :ends_after_it_starts  

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
    if starting_date_and_time > ending_date_and_time 
      errors.add(:starting_date_and_time, "must be before the ending date and time")
    else   
  end   

end




