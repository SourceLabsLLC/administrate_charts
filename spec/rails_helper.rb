ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'

system({"RAILS_ENV" => "test"}, "cd spec/dummy ; bin/rails db:reset")

require 'dummy/config/environment'
require 'rspec/rails'
require 'administrate_charts'
require 'spec_helper'
