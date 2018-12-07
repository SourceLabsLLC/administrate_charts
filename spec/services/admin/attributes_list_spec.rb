require 'rails_helper'

RSpec.describe Admin::AttributesList, type: :service do
  describe '.call' do
    it 'returns a hash containing the list of attributes to group by and to apply function' do
      expect(Admin::AttributesList.call('user')).to eq({
        attributes_to_apply_function: [
          { attribute_type: "number", value: "id" }, { attribute_type: "has-many", value: "cars" }
        ],
        group_attributes: ["id", "email", "admin", "birthday_date", "created_at", "updated_at"]
      })
    end
  end
end
