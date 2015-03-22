require 'rails_helper'

describe PagesController do
  # === Routes (REST) ===
  it { should route(:get, '/').to({:controller=>"pages", :action=>"home"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end