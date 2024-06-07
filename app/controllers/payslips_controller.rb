class PayslipsController < ApplicationController

  def index
    @contracts = policy_scope(Contract)
    @payslips = policy_scope(Payslip)
  end

  def show
    @payslip = Payslip.find(params[:id])
    @business_days = business_days_in_month(@payslip.month_of_payslip)

    authorize @payslip
  end

  def create
    @payslip = Payslip.new
    @contract = Contract.find(params[:contract_id])
    @payslip = payslip_calcul(@payslip, @contract)

    if @payslip.save!
      flash[:notice] = "La fiche de paie a été créée avec succès"
      redirect_to contract_payslip_path(@contract, @payslip)
    else
      flash[:alert] = "Erreur lors de la payslip : #{ @payslip.errors.full_messages.join(', ')}"
      redirect_to payslips_path
    end

    authorize @payslip
    authorize @contract
  end

  private

  def business_days_in_month(date)
    # Calcul la date de début et de fin du mois
    start_date = Date.new(date.year, date.month, 1)
    end_date = Date.new(date.year, date.month + 1, 1).prev_day

    # Initialiser le compteur de jours ouvrés
    business_days = 0

    (start_date..end_date).each do |day|
      # Incrémenter le compteur si le jour est un jour ouvré (ni samedi, ni dimanche)
      business_days += 1 unless day.saturday? || day.sunday?
    end

    business_days
  end

  def gross_salary(business_days, contract)
    contract.weekly_worked_hours / 5 * contract.gross_hourly_rate * business_days
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

  def payslip_calcul(payslip, contract)
    payslip.contract = contract
    payslip.month_of_payslip = Date.today
    number_of_days = business_days_in_month(payslip.month_of_payslip)
    payslip.gross_salary = gross_salary(number_of_days, contract)
    payslip.employer_contributions = employer_contributions(payslip.gross_salary)
    payslip.employee_contributions = employee_contributions(payslip.gross_salary)
    payslip.paid_amount = paid_amount(payslip.gross_salary, payslip.employee_contributions)
    return payslip
  end
end
