module Admin
  class AttributesList
    def self.call(resource)
      new(resource).call
    end

    def initialize(resource)
      @resource = resource
    end

    def call
      {
        group_attributes: group_attributes,
        attributes_to_apply_function: attributes_to_apply_function
      }
    end

    private

    attr_reader :resource

    def group_attributes
      dashboard_class::ATTRIBUTE_TYPES.select do |_, attribute_type|
        [
          Administrate::Field::HasMany,
          Administrate::Field::HasOne,
          Administrate::Field::BelongsTo
        ].exclude?(attribute_type)
      end.keys.map(&:to_s)
    end

    def attributes_to_apply_function
      attributes = dashboard_class::ATTRIBUTE_TYPES.select do |_, attribute_type|
        [
          Administrate::Field::HasMany,
          Administrate::Field::HasOne,
          Administrate::Field::Number,
        ].include?(attribute_type)
      end

      attributes.map do |attribute_name, attribute_type|
       { value: attribute_name.to_s, attribute_type: attribute_type_string(attribute_type) }
      end
    end

    def dashboard_class
      @dashboard_class ||= begin
        klass = resource.singularize.camelize + 'Dashboard'
        klass.constantize
      end
    end

    def attribute_type_string(attribute)
      case attribute.to_s
      when Administrate::Field::HasMany.to_s
        'has-many'
      when Administrate::Field::HasOne.to_s
        'has-one'
      when Administrate::Field::Number.to_s
        'number'
      end
    end
  end
end
