module ForteHelper
  require 'forte/checkout'

  def forte_checkout_button(button_label, order, options={})
    forte_checkout = Forte::Checkout.new(
      Rails.application.secrets.forte['api_login_id'],
      Rails.application.secrets.forte['secure_transaction_key'],
      order
    )
    button_attributes            = forte_checkout.button_attributes
    button_attributes[:callback] = options[:callback] if options[:callback]

    [
      javascript_include_tag(forte_checkout.javascript_source),
      button_tag(button_label, button_attributes.update(type: nil, name: nil))
    ].join.html_safe
  end
end
