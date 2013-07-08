require 'test_helper'

class StoreTypedAttributesTest < Test::Unit::TestCase

  # String tests

  test "getting an nil string attribute" do
    assert_nil TestModel.new.string_field
  end

  test "getting a string attribute" do
    model = TestModel.new(properties: { string_field: "testing" })
    assert_equal "testing", model.string_field
  end

  test "setting a nil string attribute" do
    model = TestModel.new
    model.string_field = nil
    assert_nil model.string_field
    assert !model.string_field_changed?
  end

  test "setting an empty string attribute" do
    model = TestModel.new
    model.string_field = ""
    assert_equal "", model.string_field
    assert model.string_field_changed?
  end

  test "setting a string attribute" do
    model = TestModel.new
    model.string_field = "testing"
    assert_equal "testing", model.string_field
    assert model.string_field_changed?
  end

  # Integer tests

  test "getting a nil integer attribute" do
    model = TestModel.new
    assert_nil model.integer_field
  end

  test "getting an integer attribute" do
    model = TestModel.new(properties: { integer_field: "10" })
    assert_equal 10, model.integer_field
  end

  test "setting a nil integer attribute" do
    model = TestModel.new
    model.integer_field = nil
    assert_nil model.integer_field
    assert !model.integer_field_changed?
  end

  test "setting an integer attribute" do
    model = TestModel.new
    model.integer_field = 10
    assert_equal 10, model.integer_field
    assert model.integer_field_changed?
  end

  # Float tests

  test "getting a nil float attribute" do
    model = TestModel.new
    assert_nil model.float_field
  end

  test "getting an float attribute" do
    model = TestModel.new(properties: { float_field: "1.2345" })
    assert_equal 1.2345, model.float_field
  end

  test "setting a nil float attribute" do
    model = TestModel.new
    model.float_field = nil
    assert_nil model.float_field
    assert !model.float_field_changed?
  end

  test "setting an float attribute" do
    model = TestModel.new
    model.float_field = 1.2345
    assert_equal 1.2345, model.float_field
    assert model.float_field_changed?
  end

  # Decimal tests

  test "getting a nil decimal attribute" do
    model = TestModel.new
    assert_nil model.decimal_field
  end

  test "getting an decimal attribute" do
    model = TestModel.new(properties: { decimal_field: "1.2345" })
    assert_equal BigDecimal.new("1.2345"), model.decimal_field
  end

  test "setting a nil decimal attribute" do
    model = TestModel.new
    model.decimal_field = nil
    assert_nil model.decimal_field
    assert !model.decimal_field_changed?
  end

  test "setting an decimal attribute" do
    model = TestModel.new
    model.decimal_field = BigDecimal.new("1.2345")
    assert_equal BigDecimal.new("1.2345"), model.decimal_field
    assert model.decimal_field_changed?
  end

  # JSON tests

  test "getting a nil json attribute" do
    model = TestModel.new
    assert_nil model.json_field
  end

  test "getting an json attribute" do
    object = { "foo" => "bar" }
    model = TestModel.new(properties: { json_field: object.to_json })
    assert_equal object, model.json_field
  end

  test "setting a nil json attribute" do
    model = TestModel.new
    model.json_field = nil
    assert_nil model.json_field
    assert !model.json_field_changed?
  end

  test "setting an json attribute" do
    object = { "foo" => "bar" }
    model = TestModel.new
    model.json_field = object
    assert_equal object, model.json_field
    assert model.json_field_changed?
  end

  # Boolean tests

  test "getting a nil boolean attribute" do
    model = TestModel.new
    assert_nil model.boolean_field
  end

  test "getting a boolean attribute" do
    model = TestModel.new(properties: { boolean_field: "false" })
    assert_equal false, model.boolean_field
  end

  test "setting a nil boolean attribute" do
    model = TestModel.new
    model.boolean_field = nil
    assert_nil model.boolean_field
    assert !model.boolean_field_changed?
  end

  test "setting a boolean attribute" do
    model = TestModel.new
    model.boolean_field = true
    assert_equal true, model.boolean_field
    assert model.boolean_field_changed?
  end

  # Persistance

  test "persisting string field" do
    model = TestModel.new
    model.string_field = "String"
    assert model.save
  end

  test "persisting integer field" do
    model = TestModel.new
    model.integer_field = 10
    assert model.save
  end

  test "persisting decimal field" do
    model = TestModel.new
    model.decimal_field = BigDecimal.new("1.5")
    assert model.save
  end

  test "persisting float field" do
    model = TestModel.new
    model.float_field = 1.5
    assert model.save
  end

  test "persisting JSON field" do
    model = TestModel.new
    model.json_field = { "foo" => "bar" }
    assert model.save
  end

  test "persisting boolean field" do
    model = TestModel.new
    model.boolean_field = false
    assert model.save
  end

  # Retreiving stored attributes
  
  test "retrieving a string" do
    model = TestModel.new(properties: { string_field: "testing" })
    model.save!
    model.reload

    assert_equal "testing", model.string_field
  end

  test "setting an attribute as a string and symbol" do
    model = TestModel.new

    model.attributes = { "properties" => { "string_field" => "1" } }
    model.attributes = { :properties => { :string_field => "2" } }

    assert_equal "2", model.string_field
    assert_equal ["properties"], model.changed
  end
  
end
