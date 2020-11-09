class Tutor < ApplicationRecord
 validates :name, :phone_number, :email, :years_of_experience, presence :true

end