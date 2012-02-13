module Capitan
  module Views
    class Layout < Mustache
      def title
        @title ||= 'Capitan'
      end
    end
  end
end