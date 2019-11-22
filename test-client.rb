#! /usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'catalog-api-client-ruby'

require 'optimist'
  opts = Optimist::options do
    opt :host, "Host and base endpoint for connection", :default => "ci.cloud.redhat.com/api/catalog/v1.0"
    opt :user_name, "Insights username", :type => :string, :default => "dbomhof@redhat.com"
    opt :password, "Insights password", :type => :string, :default => "redhat"
    opt :api_class, "Api to connect to", :type => :string, :default => "PortfolioApi"
    opt :operation, "Api operation ID", :type => :string, :default => "list_portfolios"
  end

p opts

CatalogApiClientRuby.configure do |config|
  config.host = opts[:host]
  config.scheme = 'https'
  config.username = opts[:user_name]
  config.password = opts[:password]
end

api_instance = Object.const_get("CatalogApiClientRuby::#{opts[:api_class]}").new
response = nil

begin
  response = api_instance.send(opts[:operation])
rescue CatalogApiClientRuby::ApiError => e
  puts "Exception when calling #{opts[:api_class]}->#{opts[:operation]}: #{e}"
end

p response
