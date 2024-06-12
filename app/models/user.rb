class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'must include both letters and numbers'
  
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
  validates :first_name, presence: true
  validates :last_name, presence: true
  end
  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/ } do
  validates :read_first, presence: true
  validates :read_last, presence: true
  end
  validates :birthday, presence: true
end
