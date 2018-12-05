require 'rails_helper'

RSpec.describe Admin::ChartsController, type: :request do
  describe 'GET data' do
    let(:params) do
      {
        resource: 'user',
        group_attribute: 'created_at',
        attribute_to_apply_function: 'id',
        function: 'count'
      }
    end

    let(:chart_data) { { '12/10/2018' => 5, '11/10/2018' => 10 } }

    it 'calls Admin::ChartProcessor passing correct params' do
      expect(Admin::ChartProcessor).to receive(:call)
        .with('user', 'created_at', 'id', 'count')

      get data_admin_charts_path(params)
    end

    it 'responds the chart data as json' do
      allow(Admin::ChartProcessor).to receive(:call).and_return(chart_data)

      get data_admin_charts_path(params)

      response_body = JSON.parse(response.body)

      expect(response_body).to eq chart_data
    end
  end

  describe 'GET resource_attributes' do
    it 'responds the resource dashboard ATTRIBUTE_TYPES as json' do
      get resource_attributes_admin_charts_path({ resource: 'user' })

      response_body = JSON.parse(response.body)

      expect(response_body).to eq({
        "group_attributes" => ["id", "email", "admin", "birthday_date", "created_at", "updated_at"],
        "attributes_to_apply_function" => [
          {"value"=>"id", "attribute_type"=>"number"},
          {"value"=>"cars", "attribute_type"=>"has-many"}
        ]
      })
    end
  end
end
