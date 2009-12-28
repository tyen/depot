class UserItem
  attr_accessor :order, :quantity, :price

  def initialize(_order, _quantity, _price)
    @order = []
    @order << _order
    @quantity = _quantity
    @price = _price
  end

  def add_order(order)
    @order << order
  end
end
