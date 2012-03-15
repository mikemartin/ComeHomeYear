require 'sinatra/base'

module Sinatra
  module Assets
    module Helpers
      def asset_path (source)
        '/assets/' + settings.sprockets.find_asset(source).logical_path
      end
    end
  end

  helpers Assets::Helpers
end