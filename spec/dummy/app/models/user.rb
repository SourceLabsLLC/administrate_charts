class User < ApplicationRecord
  has_many :cars

  def plates
    cars.pluck(:plate).join(',')
  end
end
