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


  def new_payslip(date)
    ## Constantes temp pour calculer la payslip
    start_date = Date.new(date.year, date.month, 1)
    end_date = start_date.next_month.prev_day
    payslip_period = { start_date:, end_date: }
    event_types = ["Congés", "RTT"]

    payslip = Payslip.new

    ## A améliorer : mettre le calcul des éléments de la payslip dans une méthode ou un contrôleur
    payslip.contract = self
    payslip.month_of_payslip = start_date
    business_days = business_days_in_month(payslip_period)
    worked_days = business_days - count_of_leave(event_types, payslip_period)
    payslip.gross_salary = gross_salary(worked_days, self)
    payslip.employer_contributions = employer_contributions(payslip.gross_salary)
    payslip.employee_contributions = employee_contributions(payslip.gross_salary)
    payslip.paid_amount = paid_amount(payslip.gross_salary, payslip.employee_contributions)
    return payslip
  end

  def create_previous_payslips_on_creation
    # La close guard s'applique si le contrat est sur un unique mois,
    # le test sur le nil permet que les cdi ne soient pas inclus
    return if end_date.nil? == false && (start_date.month != end_date.month && start_date.year != end_date.year)


    ## cas à gérer : contrat en CDI et/ou pas de fin de contrat
    if end_date.nil? || end_date > Date.today
      end_date = Date.today

    else
      end_date = self.end_date # cette ligne permet de garder la valeur de end_date sinon elle est mise à nil
    end

    current_date = Date.new(start_date.year, start_date.month, 1)
    while current_date <= end_date.prev_month
      payslip = new_payslip(current_date)
      payslip.save!
      current_date = current_date.next_month
    end
  end

  private

  def count_of_leave(event_types, payslip_period)
    events.where(type: event_types, start_date: payslip_period[start_date]..payslip_period[end_date]).count
  end

  def business_days_in_month(payslip_period)
    # Initialiser le compteur de jours ouvrés
    business_days = 0

    (payslip_period[:start_date]..payslip_period[:end_date]).each do |day|
      # Incrémenter le compteur si le jour est un jour ouvré (ni samedi, ni dimanche)
      business_days += 1 unless day.saturday? || day.sunday?
    end

    business_days
  end

  def gross_salary(worked_days, contract)
    contract.weekly_worked_hours / 5 * contract.gross_hourly_rate * worked_days
  end

  def employer_contributions(gross_salary)
    gross_salary * 0.44
  end

  def employee_contributions(gross_salary)
    gross_salary * 0.22
  end

  def paid_amount(gross_salary, employee_contributions)
    gross_salary - employee_contributions
  end


end
