require 'sinatra/base'
require 'active_record'
require 'logger'
require 'mustache/sinatra'
require 'capitan/views'
require 'capitan/boot'

module Capitan
  class Server < Sinatra::Base
    register Mustache::Sinatra

    set :root, File.dirname(File.expand_path(__FILE__)) + '/../..'

    set :mustache, {
      templates: 'templates/',
      namespace: Capitan
    }

    get "/" do
      mustache :home
    end

  end
end