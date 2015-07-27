require_relative 'config/application'
require_relative 'routes'

map('/')        { run ApplicationController }