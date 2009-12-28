class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :user

  def self.from_cart_item(cart_item, user_id)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li.user_id = user_id
    li
  end
end
