require 'active_support/concern'

module SerializeTypedAttributes::Concern
  extend ActiveSupport::Concern

  def write_serialized_typed_attribute(serialized_column, key, type, value=nil)
    key = key.to_s
    serialized_column = serialized_column.to_s

    serialized = send(serialized_column) || {}
    serialized.stringify_keys!

    old_value = serialized[key].try(:dup)

    if value != old_value
      attribute_will_change!(key)
      attribute_will_change!(serialized_column)
    end

    if !value.nil?
      cast_value = self.class.cast_attribute_to_serialized(value, type)
      serialized[key] = cast_value
    else
      serialized.delete(key)
    end

    send("#{serialized_column}=", serialized)
  end

  def read_serialized_typed_attribute(serialized_column, key, type)
    key = key.to_s
    serialized_column = serialized_column.to_s

    serialized = send(serialized_column) || {}
    serialized.stringify_keys!

    value = serialized[key]
    self.class.cast_attribute_from_serialized(value, type)
  end

  module ClassMethods

    def serialize_typed_attribute(serialized_column, key, type)

      define_method("#{key.to_s}=") do |value|
        write_serialized_typed_attribute(serialized_column, key, type, value)
      end

      define_method(key.to_s) do
        read_serialized_typed_attribute(serialized_column, key, type)
      end

      define_method("#{key.to_s}_changed?") do
        changed.include?(key.to_s)
      end

    end

    def cast_attribute_from_serialized(value, type)
      case type.to_sym
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
      when :boolean
        value.to_s == "true" ? true : value.to_s == "false" ? false : nil
      else
        value
      end
    end

    def cast_attribute_to_serialized(value, type)
      case type.to_sym
      when :string, :integer, :float, :boolean
        value.to_s
      when :decimal
        value.to_s('F') # persist BigDecimal using floating point notation
      when :json
        JSON.dump(value)
      else
        value.to_s
      end
    end

  end
end
