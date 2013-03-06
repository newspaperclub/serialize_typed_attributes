require 'active_record'

class TestModel < ActiveRecord::Base
  include SerializeTypedAttributes::Concern

  serialize :properties, ActiveRecord::Coders::Hstore

  serialize_typed_attribute :properties, :string_field, :string
  serialize_typed_attribute :properties, :integer_field, :integer
  serialize_typed_attribute :properties, :float_field, :float
  serialize_typed_attribute :properties, :decimal_field, :decimal
  serialize_typed_attribute :properties, :json_field, :json
end
