require "test_helper"

class RoutesTest < ActiveSupport::TestCase

  setup do
    @routes = Rails.application.routes.routes.map(&:name)
  end

  should "verify typus routes" do
    expected = %w(typus)
    expected.each { |r| assert @routes.include?(r) }
  end

  should "verify typus dashboard routes" do
    expected = %w(typus_dashboard)
    expected.each { |r| assert @routes.include?(r) }
  end

  should "verify typus account named routes" do
    expected = %w(forgot_password_typus_account_index typus_account_index new_typus_account typus_account)
    expected.each { |r| assert @routes.include?(r) }
  end

  should "verify typus session named routes" do
    expected = %w(new_typus_session typus_session)
    expected.each { |r| assert @routes.include?(r) }
  end

end
