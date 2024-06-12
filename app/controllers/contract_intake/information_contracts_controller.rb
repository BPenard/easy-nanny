module ContractIntake
  class InformationContractsController < ApplicationController
    def new
      @information_contract = InformationContract.new
      @contract = Contract.find(params[:contract])
    end

    def create
      @information_contract = set_information_contract

      if @information_contract.valid?
        @contract = Contract.find(params[:contract])
        @contract.update(information_params)

        if @contract.save
          redirect_to contract_intake_recap_contract_path(@contract)
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_information_contract
      if information_params[:end_date] == ""
        end_date = nil
      else
        end_date = Date.parse(information_params[:end_date])
      end

      InformationContract.new(
        start_date: Date.parse(information_params[:start_date]),
        weekly_worked_hours: information_params[:weekly_worked_hours],
        end_date: end_date,
        type: information_params[:type],
        gross_hourly_rate: information_params[:gross_hourly_rate]
      )



    end

    def information_params
      params.require(:contract_intake_information_contract).permit(
        :weekly_worked_hours,
        :gross_hourly_rate,
        :type,
        :start_date,
        :end_date
      )
    end
  end
end
