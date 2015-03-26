module Shoppe
  module Stripe
    module OrderExtensions
      def accept_stripe_token(token)
        begin
          if token =~ /\Atok/
            customer = ::Stripe::Customer.create({description: "Customer for order #{number} (#{first_name} #{last_name})",
                                                  email: email_address,
                                                  card: token},
                                                 Shoppe.settings.stripe_api_key)
            self.properties['stripe_customer_token'] = customer.id
            self.save
            card = customer.sources.retrieve(customer.sources.data[0][:id])
            card.name = "#{first_name} #{last_name}"
            card.address_line1 = billing_address1
            card.address_line2 = billing_address2
            card.address_city = billing_address3
            card.address_zip = billing_postcode
            card.address_country = Shoppe::Country.find_by(id: billing_country_id).name
            card.save
            @card = card
          elsif token =~ /\Acus/ && self.properties[:stripe_customer_token] != token
            self.properties['stripe_customer_token'] = token
            self.save
          elsif self.properties['stripe_customer_token'] && self.properties['stripe_customer_token'] =~ /\Acus/
            true
          else
            false
          end
        rescue Exception => e
          self.errors.add(:base, e.message)
        end
      end

      def total_without_delivery
        order_items.inject(BigDecimal(0)) { |t, i| t + i.total }
      end


      private

      def stripe_customer
        @stripe_customer ||= ::Stripe::Customer.retrieve(self.properties['stripe_customer_token'], Shoppe.settings.stripe_api_key)
      end

      def stripe_card
        @stripe_card ||= stripe_customer.cards.last
      end

    end
  end
end
