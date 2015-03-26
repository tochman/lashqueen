class ProductsController < ApplicationController
  
  before_filter do
    if params[:category_id]
      @product_category = Shoppe::ProductCategory.where(:permalink => params[:category_id]).first!
    end
    if @product_category && params[:product_id]
      @product = @product_category.products.where(:permalink => params[:product_id]).active.first!      
    end
  end
  
  def index
    @products = @product_category.products.includes(:default_image, :product_category, :variants).root.active
  end
  
  def filter
    @products = Shoppe::Product.active.with_attributes(params[:key].to_s, params[:value].to_s)
  end
  
  def categories
    @product_categories = Shoppe::ProductCategory.ordered.includes(:image)
  end
  
  def show
    @attributes = @product.product_attributes.public.to_a
  end
  
  def add_to_basket
    product_to_order = params[:variant] ? @product.variants.find(params[:variant].to_i) : @product
    current_order.order_items.add_item(product_to_order, params[:quantity].blank? ? 1 : params[:quantity].to_i)
    respond_to do |wants|
      wants.html { redirect_to request.referer }
      wants.json { render :json => {:added => true} }
    end
  rescue Shoppe::Errors::NotEnoughStock => e
    respond_to do |wants|
      wants.html { redirect_to request.referer, alert: "Tyvärr har vi inte tillräckligt av denna vara på lager. Just nu finns #{e.available_stock} st. på lager."}
      wants.json { render json: {error: 'NotEnoughStock', available_stock: e.available_stock}}
    end
  end
  
end
