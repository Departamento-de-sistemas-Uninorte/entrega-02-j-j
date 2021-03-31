class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #validates  :username, presence: true
  #validates :name, presence: true
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :tasks

  validates :email, presence: true, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: self

  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secret_key_base)
  end
  
end
