class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :prepare_for_mobile

  
  private
  
  # Returns the active order for this session
  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Shoppe::Order.create(:ip_address => request.ip, :billing_country => Shoppe::Country.where(:name => 'Sweden').first)
        session[:order_id] = order.id
        order
      end
    end
  end
  
  # Has an active order?
  def has_order?
    session[:order_id] && @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
  end  
  helper_method :current_order, :has_order?
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
     # request.user_agent =~ /Mobile|webOS/
      request.user_agent =~ /android|blackberry|iphone|ipad|ipod|iemobile|mobile|webos/i
      
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
    puts request.user_agent.red
  end
  
end
