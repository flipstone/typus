module Typus
  module Authentication
    module None

      protected

      include Base

      def authenticate
        @typus_user = FakeUser.new
      end

    end
  end
end
