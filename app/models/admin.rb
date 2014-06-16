class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :store, :dependent => :destroy
  accepts_nested_attributes_for :store, :allow_destroy => true


  validates :firstname, presence: true, length: { in: 2..50 },
            format: { with: FengValidators::LettersOnly.regex, message: FengValidators::LettersOnly.hint }
  validates :lastname, presence: true, length: { in: 2..50 },
            format: { with: FengValidators::LettersOnly.regex, message: FengValidators::LettersOnly.hint }
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }

  def feng?
    email == "wanfenghuaian@gmail.com"
  end


end