module Admin
  class DashboardsController < Admin::ApplicationController
    def new
    end

    def show
    end

    def chart_data
      model_class = params[:resource].singularize.capitalize.constantize
      data = model_class.
        group(params[:y_axis].to_sym).
        send(params[:function], params[:x_axis].to_sym)

      render json: data
    end

    def resource_attributes
      render json: dashboard_class::ATTRIBUTE_TYPES.keys.map(&:to_s)
    end

    private

    def dashboard_class
      klass = params[:resource].singularize.camelize + 'Dashboard'
      klass.constantize
    end
  end
end
