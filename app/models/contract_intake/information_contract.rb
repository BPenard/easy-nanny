module ContractIntake
  class InformationContract
    include ActiveModel::Model

    attr_accessor :start_date, :end_date, :weekly_worked_hours, :gross_hourly_rate, :type
    validates :start_date, :weekly_worked_hours, :gross_hourly_rate, :type, presence: true
  end
end
