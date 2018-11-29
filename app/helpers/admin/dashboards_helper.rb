module Admin
  module DashboardsHelper
    def resource_select_options
      Administrate::Namespace.new('admin').resources.map do |resource|
        next if resource.to_s == 'dashboards'

        [resource.to_s.humanize.titleize, resource.to_s]
      end.compact!
    end
  end
end
