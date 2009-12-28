require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  has_many :line_items

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  attr_accessor :grand_quantity, :grand_price

  def get_bought_products
    data = Hash.new
    grand_quantity = 0
    grand_price = 0
    line_items.each { |item|
      if not data[item.product]
        data[item.product] = UserItem.new(item.order, item.quantity, item.total_price)
      else
        ui = data[item.product]
        ui.add_order(item.order)
        ui.quantity = ui.quantity + item.quantity
        ui.price = ui.price + item.total_price
      end
      grand_quantity += item.quantity
      grand_price += item.total_price
    }
    @grand_quantity = grand_quantity
    @grand_price = grand_price
    data.to_a
  end

  def total_line_items_sum
    sum = 0
    @line_items.each { |item| 
      sum += item.total_price 
    }
    sum
  end

  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end

  private
    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end
end
