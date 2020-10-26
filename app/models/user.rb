class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects

  with_options presence: true do
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    EMAIL = /\A\S+@\S+\.\S+\z/.freeze
    FULL_WIDTH = /\A[ぁ-んァ-ン一-龥]/.freeze
    validates :password, format: { with: PASSWORD_REGEX, message: 'Input half_width characters' }
    validates :email, uniqueness: true, format: { with: EMAIL }
    validates :member_name, format: { with: FULL_WIDTH, message: 'is invalid. Input full-width characters.' }
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.member_name = 'ゲストユーザー'
      user.password = '123qwe'
      
    end
  end
end
