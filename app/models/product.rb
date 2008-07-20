class Product < ActiveRecord::Base
  def self.find_products_for_sale
    find(:all, :order =>"title")
  end
  
  #validation stuff...
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validates_uniqueness_of :title, :message => "must be unique"
  validates_format_of :image_url, 
                      :with    => %r{\.(gif|jpg|png)$}i,
                      :message => "must be a URL for a GIF, JPG, or PNG image"

  validates_length_of :title, :minimum => 10, :message => "is too short" 
  
  protected
  def validate
    errors.add(:price, "should be at least 0.01") if price.nil? ||  price < 0.01
  end
  
  
end

