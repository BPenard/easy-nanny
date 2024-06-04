class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :contracts
  has_many :parent_contracts, class_name: 'Contract', foreign_key: 'parent_id'
  has_many :nannies, through: :parent_contracts, source: :nanny
  has_many :nanny_contracts, class_name: 'Contract', foreign_key: 'nanny_id'
  has_many :parents, through: :nanny_contracts, source: :parent

end
