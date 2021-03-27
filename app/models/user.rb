class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #validates  :username, presence: true
  #validates :name, presence: true

  has_many :tasks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
  
end
