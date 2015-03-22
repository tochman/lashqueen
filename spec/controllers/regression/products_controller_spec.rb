require 'rails_helper'

describe ProductsController do
  # === Routes (REST) ===
  it { should route(:post, '/products/1/1/buy').to({:controller=>"products", :action=>"add_to_basket", :category_id=>1, :product_id=>1}) } 
	it { should route(:get, '/products').to({:controller=>"products", :action=>"categories"}) } 
	it { should route(:get, '/products/filter').to({:controller=>"products", :action=>"filter"}) } 
	it { should route(:get, '/products/1').to({:controller=>"products", :action=>"index", :category_id=>1}) } 
	it { should route(:get, '/products/1/1').to({:controller=>"products", :action=>"show", :category_id=>1, :product_id=>1}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end