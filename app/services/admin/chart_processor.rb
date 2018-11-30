module Admin
  class ChartProcessor
    def self.call(resource, y_axis_attribute, x_axis_attribute, x_axis_function)
      new(resource, y_axis_attribute, x_axis_attribute, x_axis_function).call
    end

    def initialize(resource, y_axis_attribute, x_axis_attribute, x_axis_function)
      @resource = resource
      @y_axis_attribute = y_axis_attribute
      @x_axis_attribute = x_axis_attribute
      @x_axis_function = x_axis_function
    end

    def call
      query = resource_class.group(y_axis_attribute.to_sym)

      case attribute_type(x_axis_attribute)
      when Administrate::Field::HasMany.to_s, Administrate::Field::HasOne.to_s
        query.joins(x_axis_attribute.to_sym).send(x_axis_function.to_sym, "#{x_axis_attribute.pluralize}.id")
      else
        query.send(x_axis_function.to_sym, x_axis_attribute.to_sym)
      end
    end

    private

    attr_accessor :resource, :y_axis_attribute, :x_axis_attribute, :x_axis_function

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
