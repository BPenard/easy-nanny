class ContractsController < ApplicationController
  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.parent_id = current_user.id
    @contract.save!
    redirect_to root_path
  end

  private

  def contract_params
    params.require(:contract).permit(:nanny_id, :parent_id, :start_date, :end_date, :type, :gross_hourly_rate, :weekly_worked_hours)
  end
end
