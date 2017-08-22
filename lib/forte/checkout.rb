module Forte
  module Hmac
    SUPORTED_HASH_METHODS = %w[md5 sha1 sha256]

    def self.signature(secret_key, secret_data, hash_method='sha1')
      unless SUPORTED_HASH_METHODS.include?(hash_method)
        raise ArgumentError,
              "invalid hash_method #{hash_method}, hash method should be one of #{SUPORTED_HASH_METHODS.join(', ')}."
      end

      OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new(hash_method),
        secret_key,
        secret_data
      )
    end
  end

  class DotNetTime < ::Time
    # See http://msdn.microsoft.com/en-us/library/system.datetime.ticks.aspx
    TICKS_SINCE_EPOCH = Time.utc(0001, 01, 01).to_i * 10000000

    def ticks
      to_i * 10000000 + nsec / 100 - TICKS_SINCE_EPOCH
    end
  end

  class Checkout
    API_VERSION     = '1.0'
    JAVASCRIPT_URLS = {
      production: 'https://checkout.forte.net/v1/js',
      sandbox:    'https://sandbox.forte.net/checkout/v1/js'
    }

    attr_accessor :api_login_id,
                  :secure_transaction_key,
                  :orderable,
                  :javascript_source

    def initialize(api_login_id, secure_transaction_key, orderable, environment=:sandbox)
      self.api_login_id           = api_login_id
      self.secure_transaction_key = secure_transaction_key
      self.orderable              = orderable
      self.javascript_source      = JAVASCRIPT_URLS[environment.to_sym]
    end

    #
    # Supported `method` types include the following:
    #
    #   * `sale`     : creates a ad-hoc transaction
    #   * `schedule` : creates a scheduled transaction
    #   * `token`    : creates a customer and paymethod token only. No transaction
    #     is generated.
    #
    def button_attributes(transaction_type='sale', hash_method='sha1')
      attributes = {
        api_login_id:    api_login_id,
        method:          transaction_type,
        version_number:  API_VERSION,
        total_amount:    orderable.total_amount,
        utc_time:        DotNetTime.now.ticks,
        order_number:    orderable.order_number,
        #
        # `customer_token` is optional if `paymethod_token` exist, and vice versa.
        #
        customer_token:  nil,
        #paymethod_token: nil,
        signature:       nil
      }

      hmac_signature = Hmac.signature(
        secure_transaction_key,
        attributes.values.join('|'),
        hash_method
      )

      attributes.update(
        hash_method: hash_method,
        signature:   hmac_signature
      )
    end
  end
end
