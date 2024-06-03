class Event < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :contract
  belongs_to :user
  belongs_to :child

  validates :date, presence: true
  validates :type, presence: true
  # validates :type, inclusion: { in: %w[TODO] }
end
