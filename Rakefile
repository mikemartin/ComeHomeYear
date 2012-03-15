require 'bundler/setup'

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV['RACK_ENV'] = args[:env] || 'development'
  require './app'
end