module Typus
  module Generators
    class ControllerGenerator < Rails::Generators::NamedBase

      source_root File.expand_path("../../templates", __FILE__)

      alias_method :resource, :name

      desc <<-MSG
Description:
  Generates admin controllers for the given resource

      MSG

      def generate_controller
        template "controller.rb", "app/controllers/typus/#{file_name}_controller.rb"
      end

      hook_for :test_framework do |instance, generator|
        instance.invoke generator, ["typus/#{instance.name}"]
      end

    end
  end
end
