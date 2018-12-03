module Admin
  module ChartsHelper
    CHART_TYPES = [['Line', :line], ['Pie', :pie], ['Column', :column], ['Bar', :bar], ['Area', :area]].freeze
    FUNCTION_TYPES = [['Sum', :sum], ['Count', :count], ['Average', :average]].freeze

    def resource_select_options
      Administrate::Namespace.new('admin').resources.map do |resource|
        next if resource.to_s == 'charts'

        [resource.to_s.humanize.titleize, resource.to_s]
      end.compact!
    end

    def attribute_select_options(resource)
      return [] unless resource

      dashboard_class = resource.singularize.camelize + 'Dashboard'

      dashboard_class.constantize::ATTRIBUTE_TYPES.keys.map(&:to_s)
    end

    def permitted_chart_params(params)
      params.permit(
        :chart_type,
        :resource,
        :group_attribute,
        :attribute_to_apply_function,
        :function
      )
    end

    def draw_chart(params)

      chart_params = permitted_chart_params(params)

      case chart_params[:chart_type]
      when 'line'
        line_chart data_admin_charts_path(chart_params),
          ytitle: chart_params[:attribute_to_apply_function].humanize,
          xtitle: chart_params[:group_attribute].humanize
      when 'pie'
        pie_chart data_admin_charts_path(chart_params)
      when 'column'
        column_chart data_admin_charts_path(chart_params),
          ytitle: chart_params[:attribute_to_apply_function].humanize,
          xtitle: chart_params[:group_attribute].humanize
      when 'bar'
        bar_chart data_admin_charts_path(chart_params),
          ytitle: chart_params[:group_attribute].humanize,
          xtitle: chart_params[:attribute_to_apply_function].humanize
      when 'area'
        area_chart data_admin_charts_path(chart_params),
          ytitle: chart_params[:attribute_to_apply_function].humanize,
          xtitle: chart_params[:group_attribute].humanize
      end
    end
  end
end
