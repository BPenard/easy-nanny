class Contract < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :nanny, class_name: 'User', foreign_key: 'nanny_id'
  belongs_to :parent, class_name: 'User', foreign_key: 'parent_id'

  has_many :payslips
  has_many :child_contracts
  has_many :children, through: :child_contracts
  has_many :events

  # validates :start_date, presence: true
  # validates :end_date, presence: true # dans le cas d'un CDI pas de end date
  # validates :type, presence: true
  # validates :type, inclusion: { in: %w[cdi cdd] }
  # validates :weekly_worked_hours, presence: true
  # validates :gross_hourly_rate, presence: true

  def display_nanny_first_name
    nanny.first_name
  end

  def has_payslip?
    payslips.exists?
  end
  
  def to_pdf
    ContractPdfGeneratorService.call(self)
  end

  def pdf_name
    "Contrat de travail (#{Date.current.strftime('%d-%m-%Y')})"
  end
end
