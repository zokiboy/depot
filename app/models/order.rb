class Order < ActiveRecord::Base
  has_many :line_items
  has_one :payment_type

  validates_presence_of :name, :address, :email, :payment_type_id
  validates_inclusion_of :payment_type_id, :in => PaymentType.find(:all).map { |p| p.id }
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
end
