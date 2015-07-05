require 'spec_helper'
require 'rack/test'
require 'sinatra'
require File.expand_path('../rack_spec_helpers', __FILE__)

class Uproot < Sinatra::Base
  set :environment, :test
end

RSpec.configure do |config|
  config.include RackSpecHelpers
  config.before(:example, :type => :feature) do
    require File.expand_path('../../app', __FILE__)
    self.app = Uproot
  end
end
