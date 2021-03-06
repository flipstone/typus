require "test_helper"

=begin

  What's being tested here?

    - Access to user_guide.
    - ...

=end

class Typus::BaseControllerTest < ActionController::TestCase

  context "non-authenticated" do

    should "not be able to get the user_guide" do
      get :user_guide
      assert_response :redirect
      assert_redirected_to new_typus_session_path(:back_to => '/typus/user_guide')
    end

  end

  context "authenticated" do

    setup do
      @request.session[:typus_user_id] = Factory(:typus_user).id
    end

    teardown do
      @request.session[:typus_user_id] = nil
    end

    should "be able to get the user_guide" do
      get :user_guide
      assert_response :success
    end

  end

end
