class Task < ApplicationRecord
  validates :state, inclusion: {
    in: %w(new started done),
    message: '%{value} is not a valid state'
  }
end
