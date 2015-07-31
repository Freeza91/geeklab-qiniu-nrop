require 'qiniu'

MyApp.configure do |app|
  Qiniu.establish_connection! :access_key => app.settings.qiniu_access_key,
                              :secret_key => app.settings.qiniu_secret_key
end