class Order < ActiveRecord::Base
  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  # Solve One-Two-One association's create_model_and_update_nested_model Problem
  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end



  def payment_types
    [['Cash ', 'cash'], ['PayPal ', 'paypal']]
  end


  TIP_RATES = [['Tip cash', 0], ['Tip $1.00', 1], ['Tip $2.00', 2], ['Tip $3.00', 3], ['Tip $4.00', 4], ['Tip $5.00', 5],
               ['Tip $6.00', 6], ['Tip $7.00', 7], ['Tip $8.00', 8], ['Tip $9.00', 9], ['Tip $10.00', 10]]


end
