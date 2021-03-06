module Admin
  module ChartsHelper
    CHART_TYPES = [['Line', :line], ['Pie', :pie], ['Column', :column], ['Bar', :bar], ['Area', :area]].freeze
    FUNCTION_TYPES = [
      ['Count', :count, { 'data-attribute-type' => 'all' }],
      ['Maximum', :maximum, { 'data-attribute-type' => 'number' }],
      ['Minimum', :minimum, { 'data-attribute-type' => 'number' }],
      ['Sum', :sum, { 'data-attribute-type' => 'number' }],
      ['Average', :average, { 'data-attribute-type' => 'number' }]
    ].freeze

    def resource_select_options
      Administrate::Namespace.new('admin').resources.map do |resource|
        next if resource.to_s == 'charts'

        [resource.to_s.humanize.titleize, resource.to_s]
      end.compact!
    end

    def group_attributes(resource)
      return [] unless resource

      attributes_list(resource)[:group_attributes]
    end

    def attribute_to_apply_function(resource)
      return [] unless resource

      attributes_list(resource)[:attributes_to_apply_function].map do |element|
        [element[:value], element[:value], { 'data-attribute-type' => element[:attribute_type] }]
      end
    end

    def attributes_list(resource)
      @attributes_list ||= begin
        Admin::AttributesList.call(resource)
      end
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
      ytitle = "#{chart_params[:function].capitalize}(#{chart_params[:attribute_to_apply_function].humanize})"
      xtitle = chart_params[:group_attribute].humanize

      case chart_params[:chart_type]
      when 'line'
        line_chart data_admin_charts_path(chart_params),
          ytitle: ytitle,
          xtitle: xtitle
      when 'pie'
        pie_chart data_admin_charts_path(chart_params)
      when 'column'
        column_chart data_admin_charts_path(chart_params),
          ytitle: ytitle,
          xtitle: xtitle
      when 'bar'
        bar_chart data_admin_charts_path(chart_params),
          ytitle: xtitle,
          xtitle: ytitle
      when 'area'
        area_chart data_admin_charts_path(chart_params),
          ytitle: ytitle,
          xtitle: xtitle
      end
    end
  end
end
