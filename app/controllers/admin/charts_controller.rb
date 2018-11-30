module Admin
  class ChartsController < Admin::ApplicationController
    def new
    end

    def show
    end

    def data
      chart_data = Admin::ChartProcessor.call(
        chart_params[:resource],
        chart_params[:group_attribute],
        chart_params[:attribute_to_apply_function],
        chart_params[:function]
      )

      render json: chart_data
    end

    def resource_attributes
      render json: dashboard_class::ATTRIBUTE_TYPES.keys.map(&:to_s)
    end

    private

    def dashboard_class
      klass = chart_params[:resource].singularize.camelize + 'Dashboard'
      klass.constantize
    end

    def chart_params
      params.permit(:chart_type, :resource, :group_attribute, :attribute_to_apply_function, :function)
    end
  end
end
