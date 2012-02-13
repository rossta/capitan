module Capitan
  module Views
    class Home < Layout

      def stacks
        @stacks ||= Stack.all
      end

    end
  end
end