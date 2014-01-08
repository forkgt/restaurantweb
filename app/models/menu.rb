class Menu < ActiveRecord::Base
  belongs_to :store

  has_many :categories, :dependent => :destroy, :order => :rank
end
