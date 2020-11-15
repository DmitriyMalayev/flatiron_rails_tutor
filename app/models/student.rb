class Student < ApplicationRecord #app/models/student.rb
  belongs_to :user
  has_many :appointments
  has_many :tutors, through: :appointments

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :phone_number, :email, presence: true
end
