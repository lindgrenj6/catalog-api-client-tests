#! /usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'catalog-api-client-ruby'
require 'optimist'

opts = Optimist::options do
  opt :host, "Host and base endpoint for connection", :default => "ci.cloud.redhat.com/api/catalog/v1.0"
  opt :scheme, "Connection scheme", :type => :string, :default => "https"
  opt :user_name, "Insights username", :type => :string, :default => "dbomhof@redhat.com"
  opt :password, "Insights password", :type => :string, :default => "redhat"
  opt :api_class, "Api to connect to", :type => :string, :default => "PortfolioApi"
  opt :operation, "Api operation ID", :type => :string, :default => "list_portfolios"
end

p opts

X_RH_IDENTITY = "eyJlbnRpdGxlbWVudHMiOnsiaHlicmlkX2Nsb3VkIjp7ImlzX2VudGl0bGVkIjp0cnVlfSwiaW5zaWdodHMiOnsiaXNfZW50aXRsZWQiOnRydWV9LCJvcGVuc2hpZnQiOnsiaXNfZW50aXRsZWQiOnRydWV9LCJzbWFydF9tYW5hZ2VtZW50Ijp7ImlzX2VudGl0bGVkIjp0cnVlfX0sImlkZW50aXR5Ijp7ImFjY291bnRfbnVtYmVyIjoiMDM2OTIzMyIsInR5cGUiOiJVc2VyIiwidXNlciI6eyJ1c2VybmFtZSI6Impkb2UiLCJlbWFpbCI6Impkb2VAYWNtZS5jb20iLCJmaXJzdF9uYW1lIjoiSm9obiIsImxhc3RfbmFtZSI6IkRvZSIsImlzX2FjdGl2ZSI6dHJ1ZSwiaXNfb3JnX2FkbWluIjpmYWxzZSwiaXNfaW50ZXJuYWwiOmZhbHNlLCJsb2NhbGUiOiJlbl9VUyJ9LCJpbnRlcm5hbCI6eyJvcmdfaWQiOiIzMzQwODUxIiwiYXV0aF90eXBlIjoiYmFzaWMtYXV0aCIsImF1dGhfdGltZSI6NjMwMH19fQ=="

X_RH_INSIGHTS_REQUEST_ID = "gobbledygook"
ORIGINAL_URL = "http://whatever.com"

CatalogApiClientRuby.configure do |config|
  config.host = opts[:host]
  config.scheme = opts[:scheme]
  config.username = opts[:user_name]
  config.password = opts[:password]
end

api_instance = Object.const_get("CatalogApiClientRuby::#{opts[:api_class]}").new
response = nil

begin
  api_instance.api_client.default_headers = {:x_rh_identity => X_RH_IDENTITY, :x_rh_insights_request_id => X_RH_INSIGHTS_REQUEST_ID, :original_url => ORIGINAL_URL }
  response = api_instance.send(opts[:operation])
rescue CatalogApiClientRuby::ApiError => e
  puts "Exception when calling #{opts[:api_class]}->#{opts[:operation]}: #{e}"
end

p response
