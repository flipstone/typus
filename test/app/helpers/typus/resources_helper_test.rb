require "test_helper"

class Typus::ResourcesHelperTest < ActiveSupport::TestCase

  include Typus::ResourcesHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper

  def render(*args); args; end

  context "display_link_to_previous" do

    setup do
      @resource = Comment
    end

    should "set an url to new when not resource_id is passed" do
      params = { :resource => "Post" }

      expected = ["typus/helpers/resources/display_link_to_previous",
                  {:body=>"Cancel adding a new comment?", :url=>{:controller=>"posts", :action => 'new'}}]

      assert_equal expected, display_link_to_previous(params)
    end

    should "set an url to edit when resource_id is passed" do
      @post = Factory(:post)
      params = { :resource => "Post", :resource_id => @post.id }

      expected = ["typus/helpers/resources/display_link_to_previous",
                  {:body=>"Cancel adding a new comment?", :url=>{:controller=>"posts", :action => 'edit', :id => @post.id}}]

      assert_equal expected, display_link_to_previous(params)
    end

    should "return nil if no resource is passed" do
      params = { :action => "edit" }
      self.expects(:params).at_least_once.returns(params)

      assert_nil display_link_to_previous
    end

  end

end
