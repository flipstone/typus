require "test_helper"

=begin

  What's being tested here?

    - Asset management like attach (edit) and detach (update).
    - Assets runnings with a custom template.

=end

class Typus::AssetsControllerTest < ActionController::TestCase

  setup do
    @request.session[:typus_user_id] = Factory(:typus_user).id
    @post = Factory(:post)
  end

  context "edit" do

    setup do
      @asset = Factory(:asset)
      @request.env['HTTP_REFERER'] = "/typus/assets/edit/#{@asset.id}"
    end

    should "verify there is a file link" do
      get :edit, :id => @asset.id
      assert_match /media/, @response.body
    end

    should "verify dragonfly can be removed" do
      get :edit, :id => @asset.id
      assert_match /Remove/, @response.body

      assert @asset.dragonfly_uid.present?

      get :update, :id => @asset.id, :attribute => "dragonfly"
      assert_response :redirect
      assert_redirected_to "/typus/assets/edit/#{@asset.id}"
      assert_equal "Asset successfully updated.", flash[:notice]

      @asset.reload
      assert @asset.dragonfly_uid.blank?
    end

    should "verify dragonfly_required can not removed" do
      get :edit, :id => @asset.id
      assert_no_match /Remove required file/, @response.body

      get :update, :id => @asset.id, :attribute => "dragonfly_required"
      assert_response :success

      @asset.reload
      assert @asset.dragonfly_required.present?
    end

    should "verify message on polymorphic relationship" do
      asset = Factory(:asset)
      get :edit, :id => asset.id, :resource => @post.class.name, :resource_id => @post.id
      assert_select 'body div#flash', "Cancel adding a new asset?"
    end

  end

  context "Headless" do

    should "render index with a custom layout" do
      get :index, :layout => "typus/headless"
      assert_response :success
      assert_template "typus/headless"
    end

    should "render new with a custom layout" do
      get :new, :layout => "typus/headless"
      assert_response :success
      assert_template "typus/headless"
    end

    should "render edit with a custom layout" do
      asset = Factory(:asset)
      get :edit, :id => asset.id, :layout => "typus/headless"
      assert_response :success
      assert_template "typus/headless"
    end

    context "create" do

      should "redirect to edit with custom layout" do
        asset = {:caption => "My Caption", :dragonfly_required => File.new("#{Rails.root}/public/images/rails.png")}

        assert_difference('Asset.count') do
          post :create, { :asset => asset, :layout => "typus/headless" }
        end

        assert_response :redirect
        assert_redirected_to :action => "edit", :id => Asset.last.id, :layout => "typus/headless"
      end

      should "redirect to index with custom layout" do
        Typus::Resources.expects(:action_after_save).returns("index")
        asset = {:caption => "My Caption", :dragonfly_required => File.new("#{Rails.root}/public/images/rails.png")}

        assert_difference('Asset.count') do
          post :create, { :asset => asset, :layout => "typus/headless" }
        end

        assert_response :redirect
        assert_redirected_to :action => "index", :layout => "typus/headless"
      end

      should "render new with custom layout after an error" do
        post :create, { :asset => {}, :layout => "typus/headless" }
        assert_response :success
        assert_template "new"
        assert_template "typus/headless"
      end

    end

    context "update" do

      setup do
        @asset = Factory(:asset)
      end

      should "redirect to edit with custom layout" do
        asset = {:caption => "My Caption", :dragonfly_required => File.new("#{Rails.root}/public/images/rails.png")}
        post :update, :id => @asset.id, :asset => asset, :layout => "typus/headless"
        assert_response :redirect
        assert_redirected_to :action => "edit", :id => @asset.id, :layout => "typus/headless"
      end

      should "render update with custom layout after an error" do
        post :update, :id => @asset.id, :asset => { :dragonfly_required => nil }, :layout => "typus/headless"
        assert_response :success
        assert_template "typus/helpers/resources/_errors"
        assert_template "typus/resources/edit"
        assert_template "typus/headless"
      end

      should "redirect to index with custom layout" do
        Typus::Resources.expects(:action_after_save).returns("index")
        asset = {:caption => "My Caption", :dragonfly_required => File.new("#{Rails.root}/public/images/rails.png")}
        post :update, :id => @asset.id, :asset => asset, :layout => "typus/headless"
        assert_response :redirect
        assert_redirected_to :action => "index", :layout => "typus/headless"
      end

    end

  end

end
