module ContractIntake
  class NannyContractsController < ApplicationController
    def new
      @nanny_contract = NannyContract.new
    end

    def create
      @nanny_contract = NannyContract.new(nanny_params)
      if @nanny_contract.valid?
        @contract = Contract.new(nanny_params)
        @contract.parent = current_user
        if @contract.save
          redirect_to new_contract_intake_information_contract_path(contract: @contract)
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def nanny_params
      params.require(:contract_intake_nanny_contract).permit(:nanny_id)
    end
  end
end
