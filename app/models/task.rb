class Task < ApplicationRecord
  PROGRESS_STATES = %w(new started done)

  validates :state, inclusion: {
    in: PROGRESS_STATES,
    message: '%{value} is not a valid state'
  }
end
