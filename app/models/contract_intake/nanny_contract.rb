module ContractIntake
  class NannyContract
    include ActiveModel::Model
    attr_accessor :nanny_id
    validates :nanny_id, presence: true
  end
end
