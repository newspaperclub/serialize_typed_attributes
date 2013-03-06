require 'test/unit'

require 'active_record'
database_path = File.join(File.dirname(__FILE__), 'database.yml')
ActiveRecord::Base.establish_connection(YAML.load_file(database_path))

require 'activerecord-postgres-hstore'
require 'support/test_model_migration'

require 'serialize_typed_attributes'
require 'test_model'
