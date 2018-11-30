module Admin
  class ChartProcessor
    def self.call(resource, group_attribute, attribute_to_apply_function, function)
      new(resource, group_attribute, attribute_to_apply_function, function).call
    end

    def initialize(resource, group_attribute, attribute_to_apply_function, function)
      @resource = resource
      @group_attribute = group_attribute
      @attribute_to_apply_function = attribute_to_apply_function
      @function = function
    end

    def call
      query = resource_class.group(group_attribute.to_sym)

      case attribute_type(attribute_to_apply_function)
      when Administrate::Field::HasMany.to_s, Administrate::Field::HasOne.to_s
        query.joins(attribute_to_apply_function.to_sym).
          send(function.to_sym, "#{attribute_to_apply_function.pluralize}.id")
      else
        query.send(function.to_sym, attribute_to_apply_function.to_sym)
      end
    end

    private

    attr_accessor :resource, :group_attribute, :attribute_to_apply_function, :function

    def dashboard_class
      klass = resource.singularize.camelize + 'Dashboard'
      klass.constantize
    end

    def resource_class
      resource.singularize.capitalize.constantize
    end

    def attribute_type(attribute)
      dashboard_class::ATTRIBUTE_TYPES[attribute.to_sym].to_s
    end
  end
end
