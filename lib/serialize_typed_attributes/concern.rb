require 'active_support/concern'

module SerializeTypedAttributes::Concern
  extend ActiveSupport::Concern

  module InstanceMethods

    def write_serialized_typed_attribute(store_column, key, type, value=nil)
      store = send(store_column) || {}
      old_value = store[key].try(:dup)

      if value != old_value
        attribute_will_change!(key)
        attribute_will_change!(store_column)
      end

      if !value.nil?
        cast_value = self.class.cast_attribute_to_store(value, type)
        store[key] = cast_value
      else
        store.delete(key)
      end

      send("#{store_column}=", store)
    end

    def read_serialized_typed_attribute(store_column, key, type)
      store = send(store_column) || {}
      value = store[key]
      self.class.cast_attribute_from_store(value, type)
    end

  end

  module ClassMethods

    def serialize_typed_attribute(store_column, key, type)

      define_method("#{key}=") do |value|
        write_serialized_typed_attribute(store_column, key, type, value)
      end

      define_method(key) do
        read_serialized_typed_attribute(store_column, key, type)
      end

      define_method("#{key}_changed?") do
        changed.include?(key)
      end

    end

    def cast_attribute_from_store(value, type)
      case type
      when :string
        value.to_s if value
      when :integer
        value.to_i if value.present?
      when :float
        value.to_f if value.present?
      when :decimal
        BigDecimal.new(value) if value.present?
      when :json
        JSON.parse(value) if value.present?
      else
        value
      end
    end

    def cast_attribute_to_store(value, type)
      case type
      when :string, :integer, :float, :decimal
        value.to_s
      when :json
        JSON.dump(value)
      else
        value.to_s
      end
    end

  end
end
