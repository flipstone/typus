module Typus
  module ResourcesHelper

    include Typus::DisplayHelper
    include Typus::ListHelper
    include Typus::FiltersHelper
    include Typus::FormHelper
    include Typus::RelationshipsHelper
    include Typus::FilePreviewHelper
    include Typus::SearchHelper
    include Typus::SidebarHelper
    include Typus::TableHelper

    def display_link_to_previous(params = params)
      if params[:resource]

        item_class = params[:resource].typus_constantize
        url = { :controller => item_class.to_resource }

        if params[:resource_id]
          item = item_class.find(params[:resource_id])
          url.merge!(:action => 'edit', :id => item.id)
        else
          url.merge!(:action => 'new')
        end

        body = Typus::I18n.t("Cancel adding a new %{resource}?", :resource => @resource.model_name.human.downcase)

        render "typus/helpers/resources/display_link_to_previous",
               :body => body,
               :url => url
      end
    end

  end
end
