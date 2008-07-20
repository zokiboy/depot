class StoreController < ApplicationController
  def index
      @products = Product.find_products_for_sale
      #@products = Product.find(:all, :order=>"title")
      
      @time = Time.current.strftime("%Y-%m-%d %H:%M:%S")
      
      @count = increment_count
  
  end

  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product" )
    else
      @cart = find_cart
      @cart.add_product(product)
      session[:counter] = 0
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index("Your cart is currently empty" )
  end
  

  private
  
  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end
  
  def find_cart
      session[:cart] ||= Cart.new
      
      #this is the same as
      #unless session[:cart]
        #session[:cart] = Cart.new
      #end
      #session[:cart]
    end

  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end



end
