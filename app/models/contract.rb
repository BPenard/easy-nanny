class Contract < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :nanny, class_name: 'User', foreign_key: 'nanny_id'
  belongs_to :parent, class_name: 'User', foreign_key: 'parent_id'

  has_many :payslips
  has_many :child_contracts
  has_many :children, through: :child_contracts
  has_many :events

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :type, presence: true
  validates :type, inclusion: { in: %w[cdi cdd] }
  validates :weekly_worked_hours, presence: true
  validates :gross_hourly_rate, presence: true
end
