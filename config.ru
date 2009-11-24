require 'lib/rack/trailingslash'
use TrailingSlash

require 'killerdumptrucks'
use Sinatra::Application
