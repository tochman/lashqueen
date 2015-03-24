module Shoppe
  module Stripe
    module OrderExtensions

      def accept_stripe_token(token)
        if token =~ /\Atok/
          customer = ::Stripe::Customer.create({description: "Customer for order #{number} (#{first_name} #{last_name})",
                                                email: email_address,
                                                card: token},
                                               Shoppe.settings.stripe_api_key)
          self.properties['stripe_customer_token'] = customer.id
          self.save
        elsif token =~ /\Acus/ && self.properties[:stripe_customer_token] != token
          self.properties['stripe_customer_token'] = token
          self.save
        elsif self.properties['stripe_customer_token'] && self.properties['stripe_customer_token'] =~ /\Acus/
          true
        else
          false
        end
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
