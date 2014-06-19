class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :firstname, presence: true, length: { in: 2..50 },
            format: { with: FengValidators::LettersOnly.regex, message: FengValidators::LettersOnly.hint }
  validates :lastname, presence: true, length: { in: 2..50 },
            format: { with: FengValidators::LettersOnly.regex, message: FengValidators::LettersOnly.hint }
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }



  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  has_many :orders
end
