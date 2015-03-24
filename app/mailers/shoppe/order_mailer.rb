module Shoppe
  class OrderMailer < ActionMailer::Base
  
    def received(order)
      @order = order
      mail from: Shoppe.settings.outbound_email_address, to: order.email_address, subject: I18n.t('shoppe.order_mailer.received.subject', default: 'Baställning mottagen')
    end
  
    def accepted(order)
      @order = order
      mail from: Shoppe.settings.outbound_email_address, to: order.email_address, subject: I18n.t('shoppe.order_mailer.received.accepted', default: 'Under bearbetning')
    end
  
    def rejected(order)
      @order = order
      mail from: Shoppe.settings.outbound_email_address, to: order.email_address, subject: I18n.t('shoppe.order_mailer.received.rejected', default: 'Beställning avvisad')
    end
  
    def shipped(order)
      @order = order
      mail from: Shoppe.settings.outbound_email_address, to: order.email_address, subject: I18n.t('shoppe.order_mailer.received.shipped', default: 'Under levereras..')
    end
    
  end
end
