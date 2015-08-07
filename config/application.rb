require File.expand_path('../boot', __FILE__)

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile

  config_file File.expand_path('../application.yml', __FILE__)
  set :root, File.expand_path('../../', __FILE__)
  set views: root + '/app/views'
  require File.expand_path('../environment', __FILE__)

end
