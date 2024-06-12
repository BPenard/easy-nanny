class Event < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :contract
  belongs_to :child
  has_one_attached :photo

  validates :start_date, presence: true
  validates :type, presence: true
  validates :type, inclusion: { in: %w[RTT Congés Absence Médicament Activité] }
end
