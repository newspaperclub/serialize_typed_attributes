serialize_typed_attributes
==

This is a Ruby gem for Rails, to add typed getter and setter fields for the keys in
an ActiveRecord object's serialized Hash.

Let's say you have an object similar to below, which uses an
[hstore](http://www.postgresql.org/docs/current/static/hstore.html) column
called `properties` as a hash. (ActiveRecord::Coders::Hstore comes from the
[`activerecord-postgres-hstore`](https://github.com/engageis/activerecord-postgres-hstore)
gem.)

    class Car
      serialize :properties, ActiveRecord::Coders::Hstore
    end

The problem is an hstore field can only store string keys and values, so
everything is cast to a string when the hash is persisted.

    car = Car.new
    car.properties = { "colour" : "red", "wheels": 4, "engine_cc": 1.8 }
    car.colour
    # "red"
    car.wheels
    # "4"

With this gem, you can add the following to your class description:

    class Car
      serialize :properties, ActiveRecord::Coders::Hstore

      serialize_typed_attribute :properties, :colour, :string
      serialize_typed_attribute :properties, :wheels, :integer
      serialize_typed_attribute :properties, :engine_cc, :float
      serialize_typed_attribute :properties, :miles_travelled, :decimal
      serialize_typed_attribute :properties, :ownership_history, :json
    end

And now you can access the hstore values as the type specified.

Importantly, for us anyway, it provides rudimentary dirty tracking, so you can
check `car.colour_changed?` after setting it.

Running the tests
--

Set `test/database.yml` to a Postgres database with hstore extension present
(`CREATE EXTENSION hstore;`). Run `rake test`.
