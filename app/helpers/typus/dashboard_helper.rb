module Typus
  module DashboardHelper

    def resources(typus_user)
      available = Typus.resources.delete_if { |r| !(typus_user.is_a?(FakeUser) || typus_user.resources.include?(r)) }
      render "typus/helpers/dashboard/resources", :resources => available
    end

  end
end
