module OrdersHelper

  def payment_details(customer_token)
    customer = Stripe::Customer.retrieve(customer_token, Shoppe.settings.stripe_api_key)
    card = customer.sources.retrieve(customer.default_source)
    "#{card.brand} (#{card.funding}): **** **** **** #{card.last4} Korthållare: #{card.name} Giltig till: #{card.exp_month}/#{card.exp_year}"
  end

end