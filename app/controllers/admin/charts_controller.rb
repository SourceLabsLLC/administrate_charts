module Admin
  class ChartsController < Admin::ApplicationController
    def new
    end

    def show
    end

    def data
      chart_data = Admin::ChartProcessor.call(
        params[:resource],
        params[:group_attribute],
        params[:attribute_to_apply_function],
        params[:function]
      )

      render json: chart_data
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
