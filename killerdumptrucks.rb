require 'rubygems'
require 'sinatra'
require 'haml'
require 'twitter'
require 'yaml'
require 'net/http'
require 'pp' # only for dev work

load "#{File.dirname(__FILE__)}/lib/metadata.rb"

Metadata.path = "#{File.dirname(__FILE__)}/views/designs"

set :haml, {:format => :html5, :attr_wrapper => '"'}

Dir.glob("lib/helpers/*").each do |helper|
  require "#{File.dirname(__FILE__)}/#{helper}"
end

helpers do
  include Killerdumptrucks::Helpers
end

configure do
  # nil
end

error do
  handle_fail
end

not_found do
  handle_fail
end

# homepage
get '/' do
  last_item = Metadata.all.sort_by {|item| item.published}.last
  redirect "/#{last_item.slug}/", 302
end

get '/feed/' do 
  @items = Metadata.all.sort_by {|item| item.published}.reverse
  content_type 'application/atom+xml', :charset => 'utf-8'
  haml :feeds, {:format => :xhtml, :layout => false}
end

get '/about/' do 
  haml :about
end

get '/random/' do
  designs = Metadata.all
  random = designs[rand(designs.length)]
  redirect "/#{random.slug}/", 302
end

get '/something-different-from/*/' do |different_from_slug|
  other_designs = Metadata.all.reject {|m| m.slug == different_from_slug}
  random = other_designs[rand(other_designs.length)]
  redirect "/#{random.slug}/", 302
end

get '/browse/' do 
  @items = Metadata.all.sort_by {|item| item.published}.reverse
  haml :browse
end

get '/*/' do |name|
  @design = Metadata[name]
  haml :"/designs/#{@design.slug}"
end