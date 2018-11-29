module Admin
  module ChartsHelper
    def resource_select_options
      Administrate::Namespace.new('admin').resources.map do |resource|
        next if resource.to_s == 'charts'

        [resource.to_s.humanize.titleize, resource.to_s]
      end.compact!
    end
  end
end
