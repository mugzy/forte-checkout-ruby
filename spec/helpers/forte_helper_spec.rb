require 'spec_helper'

describe ForteHelper do
  let(:forte_config) { Rails.application.secrets.forte }
  let(:order) do
    DummyOrder.new('FAKE_ORDER_NUMBER', 222, 'FAKE_CUSTOMER_TOKEN')
  end

  context 'sandbox environment' do
    subject { helper.forte_checkout_button('Pay Now', order) }

    describe '#forte_checkout_button' do
      it "load forte's javascript sandbox by default" do
        expect(subject).to match(
          Regexp.escape(Forte::Checkout::JAVASCRIPT_URLS[:sandbox])
        )
      end

      describe 'generated checkout button' do
        it { should     match(/api_login_id="#{forte_config['api_login_id']}"/) }
        it { should_not match(/callback=""/) }
        it { should     match(/Pay Now<\/button>/) }
      end
    end
  end
end

