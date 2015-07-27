Dir[File.dirname(__FILE__) + "/initializers/*.rb"].each {|file| require file } # init

Dir[MyApp.settings.root + "/app/models/*rb"].each {|file| require file } # model
Dir[MyApp.settings.root + "/app/helpers/*rb"].each {|file| require file } # helper
Dir[MyApp.settings.root + "/app/controllers/*rb"].each {|file| require file } # controller