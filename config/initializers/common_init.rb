require 'logger'
Dir.mkdir('log') unless File.exist?('log')
class ::Logger; alias_method :write, :<<; end
case ENV["RACK_ENV"]
when "production"
  logger = ::Logger.new("log/production.log")
  logger.level = ::Logger::WARN
when "development"
  logger = ::Logger.new(STDOUT)
  logger.level = ::Logger::DEBUG
else
  logger = ::Logger.new("/dev/null")
end

YML_CONFIG = YAML::load_file (File.expand_path('../../database.yml', __FILE__))
DB_CONFIG = YML_CONFIG[ENV["RACK_ENV"]] # must be divied, ca

ActiveRecord::Base.establish_connection DB_CONFIG
ActiveSupport.on_load :active_record do
  self.include_root_in_json = false
  self.default_timezone = :local
  self.time_zone_aware_attributes = false
  self.logger = logger
end