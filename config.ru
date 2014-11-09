require 'bundler'
Bundler.require

require File.expand_path('../lib/app', __FILE__)

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run Slacker