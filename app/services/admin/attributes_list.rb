require 'administrate/field/has_many'
require 'administrate/field/has_one'
require 'administrate/field/belongs_to'
require 'administrate/field/number'

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
      attributes = filter_attributes([
        Administrate::Field::HasMany,
        Administrate::Field::HasOne,
        Administrate::Field::BelongsTo
      ], :exclude?)

      attributes = attributes.keys.map!(&:to_s) & resource_column_names
    end

    def attributes_to_apply_function
      relation_attributes = filter_attributes([
        Administrate::Field::HasMany,
        Administrate::Field::HasOne
      ], :include?)

      attributes = filter_attributes([Administrate::Field::Number], :include?)

      attributes.select! do |key, _|
        resource_column_names.include?(key.to_s)
      end

      attributes.merge!(relation_attributes).map do |attribute_name, attribute_type|
        { value: attribute_name.to_s, attribute_type: attribute_type_string(attribute_type) }
      end
    end

    def dashboard_class
      @dashboard_class ||= begin
        klass = resource.singularize.camelize + 'Dashboard'
        klass.constantize
      end
    end

    def resource_column_names
      @resource_column_names ||= begin
        resource.singularize.camelize.constantize.column_names
      end
    end

    def filter_attributes(attributes_list, method_to_apply)
      dashboard_class::ATTRIBUTE_TYPES.select do |_, attribute_type|
        attributes_list.send(method_to_apply, attribute_type)
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
