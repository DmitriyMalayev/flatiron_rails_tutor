class Appointment < ApplicationRecord # app/models/appointment.rb
  belongs_to :tutor
  belongs_to :student

  validates :starting_date_and_time, :ending_date_and_time, :subject, presence: true
  validate :tutor_conflict, :student_conflict, if: :starts_before_it_ends?
  validate :ends_after_it_starts
  # validations => used normal validations
  # validate => used for custom validations

  def tutor_conflict
    starting = self.starting_date_and_time
    ending = self.ending_date_and_time
    conflict = tutor.appointments.any? do |appointment| #.any = Returns true if at least one element is true (or non empty array)
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
    starting_date_and_time < ending_date_and_time
  end

  def tutor_name
    self.tutor.name
  end

  def student_name
    self.student.name
  end

  def self.by_tutor(tutor)
    where(tutor_id: tutor.id)
  end

  def self.upcoming
    where("starting_date_and_time > ?", Time.now)
  end

  def self.past
    where("ending_date_and_time < ?", Time.now)
  end

  def self.most_recent
    order(starting_date_and_time: :desc)
  end

  def self.longest_ago
    order(starting_date_and_time: :asc)
  end
end
