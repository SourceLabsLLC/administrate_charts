require 'rails_helper'

RSpec.describe Admin::ChartsHelper, type: :helper do
  describe '#resource_select_options' do
    it 'returns the resource list as select options' do
      expect(helper.resource_select_options).to eq [["Users", "users"], ["Cars", "cars"]]
    end
  end

  describe '#attribute_select_options' do
    it 'returns the attributes list from a specific resource' do
      expect(helper.attribute_select_options('user')).to eq ["id", "email", "cars", "created_at", "updated_at"]
    end
  end

  describe '#draw_chart' do
    let(:params) do
      ActionController::Parameters.new({
        chart_type: chart_type,
        attribute_to_apply_function: 'id',
        group_attribute: 'created_at',
        resource: 'user'
      })
    end

    let(:permitted_params) { helper.permitted_chart_params(params) }

    context 'chart type as line_chart' do
      let(:chart_type) { 'line' }

      it 'calls line_chart helper with correct params' do
        expect(helper).to receive(:line_chart).with(
          data_admin_charts_path(permitted_params),
          ytitle: 'Id',
          xtitle: 'Created at'
        )

        helper.draw_chart(params)
      end
    end

    context 'chart type as pie_chart' do
      let(:chart_type) { 'pie' }

      it 'calls pie_chart helper with correct params' do
        expect(helper).to receive(:pie_chart).with(data_admin_charts_path(permitted_params))

        helper.draw_chart(params)
      end
    end

    context 'chart type as column_chart' do
      let(:chart_type) { 'column' }

      it 'calls column_chart helper with correct params' do
        expect(helper).to receive(:column_chart).with(
          data_admin_charts_path(permitted_params),
          ytitle: 'Id',
          xtitle: 'Created at'
        )

        helper.draw_chart(params)
      end
    end

    context 'chart type as bar_chart' do
      let(:chart_type) { 'bar' }

      it 'calls bar_chart helper with correct params' do
        expect(helper).to receive(:bar_chart).with(
          data_admin_charts_path(permitted_params),
          xtitle: 'Id',
          ytitle: 'Created at'
        )

        helper.draw_chart(params)
      end
    end

    context 'chart type as area_chart' do
      let(:chart_type) { 'area' }

      it 'calls area_chart helper with correct params' do
        expect(helper).to receive(:area_chart).with(
          data_admin_charts_path(permitted_params),
          ytitle: 'Id',
          xtitle: 'Created at'
        )

        helper.draw_chart(params)
      end
    end
  end
end
