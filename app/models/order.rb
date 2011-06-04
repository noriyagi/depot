class Order < ActiveRecord::Base
  has_many :line_items

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end

  PAYMENT_TYPES = [
    ["現金", "check"],
    ["クレジットカード", "cc"],
    ["注文書", "po"]
  ]

  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map{|disp, value| value}
end
