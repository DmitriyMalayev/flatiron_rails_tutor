class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :student

  validates :subject, :starting_date_and_time, :ending_date_and_time, presence :true 
end

