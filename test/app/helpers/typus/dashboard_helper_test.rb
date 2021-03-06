require "test_helper"

class Typus::DashboardHelperTest < ActiveSupport::TestCase

  include Typus::DashboardHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper

  def render(*args); args; end

  context "resources" do

    setup do
      @expected = ["typus/helpers/dashboard/resources", { :resources => ["Git", "Status", "WatchDog"] }]
    end

    should "work for typus_user" do
      typus_user = Factory(:typus_user)
      output = resources(typus_user)
      assert_equal @expected, output
    end

    should "work for fake_user" do
      typus_user = FakeUser.new
      output = resources(typus_user)
      assert_equal @expected, output
    end

  end

end
