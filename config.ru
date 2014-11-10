require 'bundler'
Bundler.require

ENV['RACK_ENV'] = 'production'

raise NotSupported.new("Please run in production mode") if ENV['RACK_ENV'] != 'production'

require File.expand_path('../lib/app', __FILE__)

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run Slacker