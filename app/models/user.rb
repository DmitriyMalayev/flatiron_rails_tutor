class User < ApplicationRecord
  has_many :students 
  has_many :tutors, through: :students 
  has_many :appointments, through: :students

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable 
end


