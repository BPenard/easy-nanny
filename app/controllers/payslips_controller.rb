class PayslipsController < ApplicationController

  def index
    @contracts = policy_scope(Contract)
    @payslips = policy_scope(Payslip)
  end

  def show
    @payslip = Payslip.find(params[:id])
    @contract = Contract.find(params[:contract_id])

    ## TODO : modifier cette gestion et ajouter le nb de jours travaillés
    @business_days = business_days_in_month(@payslip.month_of_payslip)

    authorize @payslip
    authorize @contract
  end

  def create
    @contract = Contract.find(params[:contract_id])
    temp_date = Date.today ## a adapter pour gérer les différentes dates
    @payslip = @contract.new_payslip(temp_date)

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

  def save_pajeemploi_date
    # Remplace ceci par la logique réelle d'enregistrement
    @payslip = Payslip.find(params[:id])
    @payslip.update(paje_emploi_send_date: Date.today)
    authorize @payslip
    render json: { message: "Date saved successfully", date: Time.now }

  end

  def save_bank_date
    # Remplace ceci par la logique réelle d'enregistrement
    @payslip = Payslip.find(params[:id])
    @payslip.update(bank_send_date: Date.today)
    authorize @payslip
    render json: { message: "Date saved successfully", date: Time.now }

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
end
