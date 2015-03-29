class PagesController < ApplicationController
  def home
    @products = Shoppe::Product.active.featured.includes(:default_image, :product_categories, :variants).root
    respond_to do |wants|
      wants.html # { render :show }
      wants.mobile #{ render :show }
    end
  end

end
