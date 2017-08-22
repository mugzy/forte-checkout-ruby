require 'spec_helper'

describe Forte do
  describe Forte::Hmac do
    it 'raise InvalidHashMethod if Hashing is not supported' do
      expect {
        Forte::Hmac.signature('key', 'data', 'dss')
      }.to raise_error(ArgumentError)
    end
  end

  describe Forte::DotNetTime do
    it { expect(Forte::DotNetTime.now).to respond_to(:ticks) }
  end

  describe Forte::Checkout do
    let(:config) { Rails.application.secrets.forte }
    let(:order) do
      DummyOrder.new('FAKE_ORDER_NUMBER', 222, 'FAKE_CUSTOMER_TOKEN')
    end
    subject do
      Forte::Checkout.new(
        config['api_login_id'],
        config['secure_transaction_key'],
        order
      )
    end

    its(:api_login_id)           { should eq(config['api_login_id']) }
    its(:secure_transaction_key) { should eq(config['secure_transaction_key']) }
    its(:javascript_source) do
      should eq(Forte::Checkout::JAVASCRIPT_URLS[:sandbox])
    end

    context '#button_attributes.keys' do
      let(:button_attribute_values) { subject.button_attributes.values }

      it { expect(button_attribute_values).to include(config['api_login_id']) }
      it { expect(button_attribute_values).to include(Forte::Checkout::API_VERSION) }
    end
  end
end
