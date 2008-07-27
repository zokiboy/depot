class StoreController < ApplicationController
  def index
      @products = Product.find_products_for_sale
      @cart = find_cart
      
      #@time = Time.current.strftime("%Y-%m-%d %H:%M:%S")
      #@count = increment_count
  
  end


 def add_to_cart
   begin                     
     product = Product.find(params[:id])  
   rescue ActiveRecord::RecordNotFound
     logger.error("Attempt to access invalid product #{params[:id]}")
     redirect_to_index("Invalid product")
   else
     @cart = find_cart
     @current_item = @cart.add_product(product)
     redirect_to_index unless request.xhr?
   end
 end
   
  def empty_cart
    session[:cart] = nil
    redirect_to_index unless request.xhr?
  end
  
  def remove_from_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product")
    else
      @cart = find_cart
      @current_item = @cart.remove_product(product)
      redirect_to_index unless request.xhr?
    end
  end
  
  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  
  def save_order
    @cart = find_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      redirect_to_index("Thank you for your order")
    else
      render :action => :checkout
    end
  end
  

  private
  
  def redirect_to_index(msg=nil)
    flash[:notice] = msg if msg
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
