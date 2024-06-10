module ContractIntake
  class RecapContractsController < ApplicationController
    def show
      @contract = Contract.find(params[:id])
      authorize @contract
    end
  end
end
