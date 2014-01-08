class Category < ActiveRecord::Base
  belongs_to :menu

  has_many :dishes, :dependent => :destroy, :order => :rank
end
