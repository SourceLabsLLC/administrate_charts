require 'rails_helper'

RSpec.describe Admin::ChartProcessor, type: :service do
  describe '.call' do
    context 'grouping and appying function on default field types' do
      before do
        User.create(email: 'user1@email.com', admin: true)
        User.create(email: 'user2@email.com', admin: true)
        User.create(email: 'user3@email.com', admin: true)
        User.create(email: 'user4@email.com', admin: false)
        User.create(email: 'user5@email.com', admin: false)
      end

      it 'returns the chart data' do
        result = Admin::ChartProcessor.call('user', 'admin', 'id', 'count')

        expect(result).to eq({ false => 2, true => 3 })
      end
    end

    context 'grouping by DateTime field and appying function on a relation' do
      before do
        user = User.create(email: 'user1@email.com', birthday_date: Date.new(2018, 10, 11))
        user.cars.create(plate: 'xcv123')

        user = User.create(email: 'user2@email.com', birthday_date: Date.new(2018, 10, 12))

        2.times do |i|
          user.cars.create(plate: "vcx12#{i}")
        end
      end

      it 'returns the chart data' do
        result = Admin::ChartProcessor.call('user', 'birthday_date', 'cars', 'count')

        expect(result).to eq({ "10/11/2018" => 1, "10/12/2018" => 2 })
      end
    end
  end
end
