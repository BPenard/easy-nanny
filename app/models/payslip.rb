class Payslip < ApplicationRecord
  belongs_to :contract
  # belongs_to :nanny # Pourquoi cette ligne fait péter l'enregistrement de la seed ?


  # validates :month_of_payslip, presence: true
  # validates :payment_date, presence: true
  # validates :paid_amount, presence: true
  # validates :employer_contributions, presence: true
  # validates :employee_contributions, presence: true
  # validates :gross_salary, presence: true
  # validates :tax_rate, presence: true
end
