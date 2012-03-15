$stdout.sync = true if ENV['RACK_ENV'] == 'development'

require 'bundler'
Bundler.require

require 'sinatra/capture'
require 'sinatra/content_for'
require 'sinatra/namespace'
require 'logger'

class App < Sinatra::Application
  register Sinatra::Namespace

  set :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }

  enable :logging

  set :sprockets, Sprockets::Environment.new(root)
  set :asset_prefix, 'assets'
  set :asset_path, root('public', asset_prefix)

  configure do
    sprockets.append_path(File.join(root, asset_prefix, 'stylesheets'))
    sprockets.append_path(File.join(root, asset_prefix, 'javascripts'))
    sprockets.append_path(File.join(root, asset_prefix, 'images'))
  end

  configure :development do
    register Sinatra::Reloader
  end

  helpers do
    include Rack::Utils
    include Sinatra::ContentFor
    include Sinatra::JSON
    alias_method :h, :escape_html

    def development?
      App.development?
    end

    def production?
      App.production?
    end
  end
end

Dir['./{helpers,models,routes}/*.rb'].each { |file| require file }