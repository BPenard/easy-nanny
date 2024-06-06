module ContractIntake
  class InformationContractsController < ApplicationController
    def new
      @information_contract = InformationContract.new
      @contract = Contract.find(params[:contract])
    end

    def create
      @information_contract = set_information_contract(information_params)
      if @information_contract.valid?
        @contract = Contract.find(params[:contract])
        @contract.update(information_params)
        if @contract.save
          redirect_to contracts_path
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_information_contract(params)
      InformationContract.new(start_date: start_date_to_date(params),
      end_date: end_date_to_date(params),
      weekly_worked_hours: params[:weekly_worked_hours],
      type: params[:type],
      gross_hourly_rate: params[:gross_hourly_rate])
    end

    def start_date_to_date(params)
      start_date = Date.parse("#{params["start_date(1i)"]}-#{params["start_date(2i)"]}-#{params["start_date(3i)"]}")
    end

    def end_date_to_date(params)
      start_date = Date.parse("#{params["end_date(1i)"]}-#{params["end_date(2i)"]}-#{params["end_date(3i)"]}")
    end

    def information_params
      params.require(:contract_intake_information_contract).permit(
        :weekly_worked_hours, :gross_hourly_rate, :type,
        :start_date, :end_date
      )
    end
  end
end
