class ContractsController < ApplicationController
  include Stomp::Controller
 
  def new
    @contract = build_record_for(Contract)
    authorize @contract
  end

  def create
    @contract = Contract.new(contract_params)
    # @contract.parent_id = current_user.id
    if params[:commit] == "create" && @contract.all_steps_valid?
      @contract.save!
      redirect_to contract_path @contract
    else
      @contract.step!(params[:commit])
      redirect_to next_step_path_for(@contract, path: :new_contract_path)
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:start_date, :end_date, :type, :gross_hourly_rate, :weekly_worked_hours, :serialized_steps_data)
  end
end
