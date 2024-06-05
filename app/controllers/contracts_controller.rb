class ContractsController < ApplicationController
  def new
    @contract = Contract.new
    authorize @contract
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.parent_id = current_user.id
    @contract.save!
    redirect_to root_path
    authorize @contract
  end

  def index
    @contracts = policy_scope(Contract)
  end

  private

  def contract_params
    params.require(:contract).permit(:nanny_id, :parent_id, :start_date, :end_date, :type, :gross_hourly_rate, :weekly_worked_hours)
  end
end
