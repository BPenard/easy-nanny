class Contract < ApplicationRecord
  self.inheritance_column = nil

  include Stomp::Model

  stomp! validate: :each_step

  belongs_to :nanny, class_name: 'User', foreign_key: 'nanny_id'
  belongs_to :parent, class_name: 'User', foreign_key: 'parent_id'
  
  has_many :payslips
  has_many :child_contracts
  has_many :children, through: :child_contracts
  has_many :events

  define_steps step_1: [:start_date, :end_date], 
             step_2: [:type, :weekly_worked_hours, :gross_hourly_rate]

  define_step_validations step_2: {
              type: { presence: true}
            }       

  # validates :start_date, presence: true
  # validates :end_date, presence: true # dans le cas d'un CDI pas de end date
  # validates :type, presence: true
  # validates :type, inclusion: { in: %w[cdi cdd] }
  # validates :weekly_worked_hours, presence: true
  # validates :gross_hourly_rate, presence: true
end
