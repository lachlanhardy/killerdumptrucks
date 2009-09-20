require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'twitter'
require 'yaml'
require 'net/http'
require 'pp' # only for dev work

module Killerdumptrucks
  load "#{File.dirname(__FILE__)}/lib/metadata.rb"

  set :haml, {:format => :html5, :attr_wrapper => '"'}
  
  class App < Sinatra::Application
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
      haml :index
    end
    
    get '/feed/' do 
      @items = Metadata.type(@category.to_sym).all.sort_by {|item| item.published}.reverse
      content_type 'application/atom+xml', :charset => 'utf-8'
      haml :feeds, {:format => :xhtml, :layout => false}
    end
    
    get '/about/' do 
      haml :about
    end

    get '/:name/' do 
      @design = params[:name]
      pp @design
      haml File.join("/designs/", @design).to_sym
    end
  end
end
