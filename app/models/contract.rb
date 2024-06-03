class Contract < ApplicationRecord
  self.inheritance_column = nil

  has_many :payslips
  has_many :user_contracts
  has_many :user, through: :user_contracts
  has_many :child_contracts
  has_many :children, through: :child_contracts
  has_many :events

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :type, presence: true
  validates :type, inclusion: { in: %w[cdi cdd] }
  validates :weekly_worked_hours, presence: true
end
