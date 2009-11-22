require 'rubygems'
require 'sinatra'
require 'haml'
require 'twitter'
require 'yaml'
require 'net/http'
require 'pp' # only for dev work

load "#{File.dirname(__FILE__)}/lib/metadata.rb"

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
  @items = Metadata.all.sort_by {|item| item.published}.reverse
  @design = @items[0].path.split(".")[0].split("/")[-1]
  redirect "/#{@design}/", 302
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
  items = Metadata.all
  random_item = items[rand(Metadata.all.length)]
  redirect "/#{random_item.slug}/", 302
end

get '/browse/' do 
  @items = Metadata.all.sort_by {|item| item.published}.reverse
  @design = @items[0].path.split(".")[0].split("/")[-1]
  haml :browse
end

get '/:name/' do 
  @design = params[:name]
  haml :"/designs/#{@design}"
end
