class StoreController < ApplicationController
  def index
      @products = Product.find_products_for_sale
      #@products = Product.find(:all, :order=>"title")
      
      @time = Time.current.strftime("%Y-%m-%d %H:%M:%S")
  end

end
