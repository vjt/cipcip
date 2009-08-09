require 'yaml'
require 'active_record'
require 'authlogic'
require 'lib/authlogic_sinatra'
require 'lib/authlogic_md5crypt'

$db = YAML.load File.read('database.yml')

ActiveRecord::Base.establish_connection $db['data']
ActiveRecord::Base.logger = Logger.new(STDOUT)
