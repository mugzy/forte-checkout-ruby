class DummyOrder < Struct.new(:order_number, :total_amount, :customer_token)
  def order_number
    "FAKE_ORDER_NUMBER##{SecureRandom.hex(5)}"
  end
end
