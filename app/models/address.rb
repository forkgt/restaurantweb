class Address < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateAddresses < ActiveRecord::Migration
  #  def change
  #    create_table :addresses do |t|
  #      t.string :address1
  #      t.string :address2
  #      t.string :city
  #      t.string :state
  #      t.string :country
  #      t.string :zip
  #      t.float :latitude
  #      t.float :longitude
  #      t.boolean :gmaps
  #      t.references :addressable, index: true, :polymorphic => true
  #
  #      t.timestamps
  #    end
  #  end
  #end

  validates_presence_of :address1, :city, :zip, :state, :country

  belongs_to :addressable, :polymorphic => true


  # ========== geocoder ==========

  geocoded_by :address, if: ->(obj){ obj.address.present? and obj.address.changed? }

  after_validation :geocode

  # Dont include address2 for geocode
  # Descriptive address info will bring mistakes in coordinates
  def address
    [address1, city, state, country, zip].compact.join(', ')
  end
end
