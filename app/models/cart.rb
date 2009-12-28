class Cart
	attr_reader :items

	def initialize
		@items = []
	end

	def add_product(product)
		current_item = @items.find {|item| item.product == product}
		if current_item
			current_item.increment_quantity
		else
      current_item = CartItem.new(product)
			@items << current_item
		end
    current_item
	end

  def delete_product(product)
		current_item = @items.find {|item| item.product == product}
    if current_item
      current_item.decrement_quantity
      @items.delete(current_item) if current_item.quantity == 0
    end
  end

  def total_num_items
    @items.length
  end

  def total_items
    @items.sum { |item| item.quantity }
  end

  def total_price
    @items.sum { |item| item.price }
  end
end
