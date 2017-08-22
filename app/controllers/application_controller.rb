class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @order = DummyOrder.new('FAKE_ORDER_NUMBER', 222, 'FAKE_CUSTOMER_TOKEN')
  end
end
