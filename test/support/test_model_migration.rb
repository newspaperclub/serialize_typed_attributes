ActiveRecord::Migration.create_table :test_models, :force => true do |t|
  t.hstore :properties
end
