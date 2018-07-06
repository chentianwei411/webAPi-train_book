class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reservations
  has_one_attached :image

  before_create :generate_authentication_token

  def generate_authentication_token
    self.authenication_token = Devise.friendly_token
  end
end
