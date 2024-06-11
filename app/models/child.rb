class Child < ApplicationRecord
  has_many :child_contracts
  has_many :contracts, through: :child_contracts
  has_many :events
  belongs_to :user
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true

end
