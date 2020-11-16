class Tutor < ApplicationRecord
  has_many :appointments
  has_many :students, through: :appointments

  validates :name, :phone_number, :email, :years_of_experience, presence: true
end
