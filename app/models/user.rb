class User < ApplicationRecord
  has_many :students 
  has_many :tutors, through: :students 
  has_many :appointments, through: :students

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, 
  :omniauthable, omniauth_providers: [:google_oauth2] 

  def self.fromGoogle(uid:, email:, full_name:, avatar_url:)
   user = User.find_or_create_by(email: email) do |u|
      u.uid = uid 
      u.full_name = full_name 
      u.avatar_url = avatar_url
      u.password = SecureRandom.hex 
    end
    user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
  end 
end