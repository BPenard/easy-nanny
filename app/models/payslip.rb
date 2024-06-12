class Payslip < ApplicationRecord
  #la méthode ci dessous permet de renvoyer pas défaut les payslips par ordre décroissant.
  # c'est déconseillé de le mettre dans le model car on l'oublie. Plutôt directement dans le controleur quand on en a besoin
  # default_scope { order(month_of_payslip: :desc) }

  belongs_to :contract
  has_one :nanny, through: :contract
  has_many :events, through: :contract


  validates :month_of_payslip, presence: true
  # validates :payment_date, presence: true
  validates :paid_amount, presence: true
  validates :employer_contributions, presence: true
  validates :employee_contributions, presence: true
  validates :gross_salary, presence: true
  # validates :tax_rate, presence: true
end
