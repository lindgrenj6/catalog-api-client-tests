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
  opt :id, "Api operation param id", :type => :string
end

p opts

# dbomhof@redhat.com external_tenant id: 1460290
X_RH_IDENTITY = "eyJlbnRpdGxlbWVudHMiOnsiaW5zaWdodHMiOnsiaXNfZW50aXRsZWQiOnRydWV9LCJtaWdyYXRpb25zIjp7ImlzX2VudGl0bGVkIjp0cnVlfSwiaHlicmlkX2Nsb3VkIjp7ImlzX2VudGl0bGVkIjp0cnVlfSwib3BlbnNoaWZ0Ijp7ImlzX2VudGl0bGVkIjp0cnVlfSwic21hcnRfbWFuYWdlbWVudCI6eyJpc19lbnRpdGxlZCI6dHJ1ZX0sImFuc2libGUiOnsiaXNfZW50aXRsZWQiOnRydWV9fSwiaWRlbnRpdHkiOnsiaW50ZXJuYWwiOnsiYXV0aF90aW1lIjowLCJhdXRoX3R5cGUiOiJqd3QtYXV0aCIsIm9yZ19pZCI6IjYzNDAwNTYifSwiYWNjb3VudF9udW1iZXIiOiIxNDYwMjkwIiwidXNlciI6eyJmaXJzdF9uYW1lIjoiRHJldyIsImlzX2FjdGl2ZSI6dHJ1ZSwiaXNfaW50ZXJuYWwiOnRydWUsImxhc3RfbmFtZSI6IkJvbWhvZiIsImxvY2FsZSI6ImVuX1VTIiwiaXNfb3JnX2FkbWluIjpmYWxzZSwidXNlcm5hbWUiOiJkYm9taG9mQHJlZGhhdC5jb20iLCJlbWFpbCI6ImRib21ob2YrcWFAcmVkaGF0LmNvbSJ9LCJ0eXBlIjoiVXNlciJ9fQ=="

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
  if opts[:id]
    response = api_instance.send(opts[:operation], opts[:id])
  else
    response = api_instance.send(opts[:operation])
  end
rescue CatalogApiClientRuby::ApiError => e
  puts "Exception when calling #{opts[:api_class]}->#{opts[:operation]}: #{e}"
end

p response
