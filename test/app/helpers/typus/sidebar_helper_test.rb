# -*- encoding: utf-8 -*-

require "test_helper"

class Typus::SidebarHelperTest < ActiveSupport::TestCase

  include Typus::SidebarHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def render(*args); args; end
  def link_to(*args); args; end

  setup do
    default_url_options[:host] = 'test.host'
  end

  context "export" do

    should "return array with expected values" do
      params = { :controller => '/typus/posts', :action => 'index' }

      output = export(Post , params)
      expected = [["Export as CSV", { :action => "index", :format => "csv", :controller => "/typus/posts" }],
                  ["Export as XML", { :action => "index", :format => "xml", :controller => "/typus/posts" }]]

      assert_equal expected, output
    end

  end

end
