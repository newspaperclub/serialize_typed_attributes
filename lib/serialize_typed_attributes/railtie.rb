class SerializeTypedAttributes::Railties < Rails::Railtie
  initializer 'serialize_typed_attributes.initialize' do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.send(:include, SerializeTypedAttributes::Concern)
    end
  end
end
