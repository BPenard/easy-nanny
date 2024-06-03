class Child < ApplicationRecord
  has_many :child_contracts
  has_many :contracts, throught: :child_contracts
  has_many :events

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
end
