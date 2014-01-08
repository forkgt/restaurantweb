class Subscription < ActiveRecord::Base
  belongs_to :store
  belongs_to :subscribable, :polymorphic => true
end