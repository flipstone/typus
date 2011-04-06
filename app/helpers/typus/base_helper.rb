module Typus
  module BaseHelper

    def title(page_title)
      content_for(:title) { page_title }
    end

    def header
      render "typus/helpers/base/header"
    end

    def has_root_path?
      Rails.application.routes.routes.map(&:name).include?("root")
    end

    def apps
      render "typus/helpers/base/apps"
    end

    def login_info
      unless typus_user.is_a?(FakeUser)
        render "typus/helpers/base/login_info"
      end
    end

    def typus_sign_out_path
      case Typus.authentication
      when :devise
        send("destroy_#{Typus.user_class_name.underscore}_session")
      else
        destroy_typus_session_path
      end
    end

    def display_flash_message(message = flash)
      if message.compact.any?
        render "typus/helpers/base/flash_message",
               :flash_type => message.keys.first,
               :message => message
      end
    end

  end
end
