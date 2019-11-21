#! /usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

Bundler.require
# Load the gem
require 'catalog-api-client-ruby'

# Setup authorization
CatalogApiClientRuby.configure do |config|
  # Configure HTTP basic authorization: BasicAuth
  config.username = 'dbomhof@redhat.com'
  config.password = 'redhat'
end

api_instance = CatalogApiClientRuby::DefaultApi.new

begin
  #Return this API document in JSON format
  api_instance.get_documentation
rescue CatalogApiClientRuby::ApiError => e
  puts "Exception when calling DefaultApi->get_documentation: #{e}"
end
