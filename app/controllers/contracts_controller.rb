class ContractsController < ApplicationController
  def new
    @contract = Contract.new
    authorize @contract
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.parent_id = current_user.id
    @contract.save!
    redirect_to contracts_path
    authorize @contract
  end

  def index
    @contracts = policy_scope(Contract)
  end

  def show
    @contract = Contract.find(params[:id])
    authorize @contract
    ContractPdfGeneratorService.call(@contract)
    send_file "#{Rails.root}/tmp/ContratEasyNanny.pdf", type: 'application/pdf', disposition: 'attachment', filename: "ContratEasyNanny.pdf"
  end

  def recap
    @contract = Contract.find(params[:id])
  end

  def edit
    @contract = Contract.find(params[:id])
    authorize @contract
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    authorize @contract
    redirect_to contracts_path
  end

  private

  def contract_params
    params.require(:contract).permit(:nanny_id, :parent_id, :start_date, :end_date, :type, :gross_hourly_rate, :weekly_worked_hours)
  end
end
