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


  def count_of_leave
    events.where(type: ["Congés", "RTT"]).count
  end

  def business_days_in_month
    # Initialiser le compteur de jours ouvrés
    business_days = 0

    (month_of_payslip.beginning_of_month..month_of_payslip.end_of_month).each do |day|
      # Incrémenter le compteur si le jour est un jour ouvré (ni samedi, ni dimanche)
      business_days += 1 unless day.saturday? || day.sunday?
    end

    business_days
  end


end
