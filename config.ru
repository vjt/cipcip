# vim: ft=ruby

require 'rubygems'
require 'sinatra'

Sinatra::Application.set(
  :run         => false,
  :environment => ENV['RACK_ENV'].to_sym
)

require 'cipcip'
run Sinatra::Application
