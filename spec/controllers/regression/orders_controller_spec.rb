require 'rails_helper'

describe OrdersController do
  # === Routes (REST) ===
  it { should route(:post, '/checkout/delivery').to({:controller=>"orders", :action=>"change_delivery_service"}) } 
	it { should route(:post, '/basket/1').to({:controller=>"orders", :action=>"change_item_quantity", :order_item_id=>1}) } 
	it { should route(:get, '/checkout').to({:controller=>"orders", :action=>"checkout"}) } 
	it { should route(:get, '/checkout/confirm').to({:controller=>"orders", :action=>"confirmation"}) } 
	it { should route(:delete, '/basket').to({:controller=>"orders", :action=>"destroy"}) } 
	it { should route(:get, '/checkout/pay').to({:controller=>"orders", :action=>"payment"}) } 
	it { should route(:delete, '/basket/delete/1').to({:controller=>"orders", :action=>"remove_item", :order_item_id=>1}) } 
	it { should route(:get, '/order/1').to({:controller=>"orders", :action=>"status", :token=>1}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end