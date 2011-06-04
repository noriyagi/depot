class Product < ActiveRecord::Base
  has_many :line_items
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validate :price_must_ba_at_least_cant
  validates_uniqueness_of :title
  validates_format_of :image_url,
    :with => %r{\.(gif|jpg|png)$}i, :message => 'は指定形式のURLでなければなりません'

  def self.find_products_for_sale
    find(:all,:order => "title")
  end
  
 protected
  def price_must_ba_at_least_cant
    errors.add(:price, 'は、最小でも0.01以上でなければなりません。') if price.nil? || price < 0.01
  end
  
end
