class Student < ApplicationRecord
  belongs_to :user
  validates :name, :phone_number, :email,  presence: true
end
