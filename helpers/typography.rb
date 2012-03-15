module Sinatra
  module Typography
    module Helpers
      include Sinatra::Capture

      def typogruby(&blk)
        Typogruby.improve(capture(&blk))
      end
    end
  end

  helpers Typography::Helpers
end