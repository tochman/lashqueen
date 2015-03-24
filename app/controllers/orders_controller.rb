class OrdersController < ApplicationController
  
  before_filter(:except => :status) { redirect_to root_path unless has_order? }
  
  def status
    @order = Shoppe::Order.find_by_token!(params[:token])
  end
  
  def destroy
    current_order.destroy
    session[:order_id] = nil
    respond_to do |wants|
      wants.html { redirect_to root_path, notice: 'Din varukorg har tömts på alla varor'}
      wants.json do
        flash[:notice] = 'Din varukorg är nu tom.'
        render json: {status: 'complete', :redirect => root_path}
      end
    end
  end
  
  def remove_item
    item = current_order.order_items.find(params[:order_item_id])
    if current_order.order_items.count == 1
      destroy
    else
      item.remove
      respond_to do |wants|
        wants.html { redirect_to request.referer, :notice => "Item has been removed from your basket successfully"}
        wants.json do
          current_order.reload
          render :json => {:status => 'complete', :items => render_to_string(:partial => 'shared/order_items.html', :locals => {:order => current_order})}
        end
      end
    end
  end
  
  def change_item_quantity
    item = current_order.order_items.find(params[:order_item_id])
    request.delete? ? item.decrease! : item.increase!
    respond_to do |wants|
      wants.html { redirect_to request.referer || root_path, notice: 'Kvantitet har uppdaterats.' }
      wants.json do
        current_order.reload
        if current_order.empty?
          destroy
        else
          render :json => {:status => 'complete', :items => render_to_string(:partial => 'shared/order_items.html', :locals => {:order => current_order})}
        end
      end
    end    
  rescue Shoppe::Errors::NotEnoughStock => e
    respond_to do |wants|
      wants.html { redirect_to request.referer, alert: "Tyvärr, lagersadot tillåter inte att du lägger till fler av denna produkt. Vi har bara #{e.available_stock} st på lager just nu." }
      wants.json { render json: {status: 'error', message: 'Tyvärr, lagersadot tillåter inte att du lägger till fler av denna produkt'} }
    end
  end

  def change_delivery_service
    if current_order.delivery_service = current_order.available_delivery_services.select { |s| s.id == params[:delivery_service].to_i}.first
      current_order.save
      respond_to do |wants|
        wants.html { redirect_to request.referer, notice: 'Ändrade fraktmetod'}
        wants.json do
          current_order.reload
          render json: {status: 'complete', items: render_to_string(partial: 'shared/order_items.html', locals: {order: current_order})}
        end
      end
    else
      respond_to do |wants|
        wants.html { redirect_to request.referer, :alert => 'Du kan inte välja denna fraktmetod.'}
        wants.json { render :json => {:status => 'error', :message => 'InvalidDeliveryMethod'}, :status => 422 }
      end
    end
  end
  
  def checkout
    @order = Shoppe::Order.find(current_order.id)

    
    if request.patch?
      if params[:order][:billing_address4].blank?
        params[:order][:billing_address4] = params[:order][:billing_address3]
      end
      @order.attributes = params[:order].permit(:first_name, :last_name, :company, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number, :delivery_name, :delivery_address1, :delivery_address2, :delivery_address3, :delivery_address4, :delivery_postcode, :delivery_country_id, :separate_delivery_address)
      @order.ip_address = request.ip
      if @order.proceed_to_confirm
        redirect_to checkout_payment_path
      end
    else
      # Add some example order data for the example. In a real application
      # this shouldn't be present.
      #Faker::Config.locale = 'en-gb'
      # @order.first_name = Faker::Name.first_name                                            if @order.first_name.blank?
      # @order.last_name = Faker::Name.last_name                                              if @order.last_name.blank?
      # @order.company = Faker::Company.name                                                  if @order.company.blank?
      # @order.email_address = Faker::Internet.email                                          if @order.email_address.blank?
      # @order.phone_number = Faker::PhoneNumber.phone_number                                 if @order.phone_number.blank?
      # @order.billing_address1 = Faker::Address.building_number + " " + Faker::Address.street_name   if @order.billing_address1.blank?
      # @order.billing_address3 = Faker::Address.city                                                 if @order.billing_address3.blank?
      # @order.billing_postcode = Faker::Address.zip                                                  if @order.billing_postcode.blank?
    end
  end

  def payment
    @order = Shoppe::Order.find(session[:order_id])
    if request.post?
      if @order.accept_stripe_token(params[:stripe_token])
        redirect_to checkout_confirmation_path
      else
        flash.now[:notice] = 'Could not exchange Stripe token. Please try again.'
      end
    end
  end

  
  def confirmation
    unless current_order.confirming?
      redirect_to checkout_path
      return
    end
    
    if request.patch?
      begin
        current_order.confirm!
        current_order.payments.create(:method => 'Credit Card', :amount => current_order.total, :reference => rand(10000) + 10000, :refundable => true)
        session[:order_id] = nil
        redirect_to root_path, :notice => 'Din beställning har skickats iväg. Kolla din inbox!'
      rescue Shoppe::Errors::PaymentDeclined => e
        flash[:alert] = "Betalningen kunde inte genomföras. #{e.message}"
        redirect_to checkout_path
      rescue Shoppe::Errors::InsufficientStockToFulfil
        flash[:alert] = "We're terribly sorry but while you were checking out we ran out of stock of some of the items in your basket. Your basket has been updated with the maximum we can currently supply. If you wish to continue just use the button below."
        redirect_to checkout_path
      end
    end
  end
    
end
