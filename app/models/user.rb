class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :contracts
  has_many :children
  has_many :parent_contracts, class_name: 'Contract', foreign_key: 'parent_id'
  has_many :nannies, through: :parent_contracts, source: :nanny
  has_many :nanny_contracts, class_name: 'Contract', foreign_key: 'nanny_id'
  has_many :parents, through: :nanny_contracts, source: :parent
  has_many :payslips, through: :nanny_contracts

  # methodes de classe
  scope :all_nannies, -> { where("role = ?", "nanny") }
  scope :all_parents, -> { where("role = ?", "parent") }

  def events
  end

  def nanny?
    self.role == "nanny"
  end

  def parent?
    self.role == "parent"
  end

  def events
    Event.where(contract: nanny? ? nanny_contracts : parent_contracts)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end


# User.nanny => renvoyer toutes les nannies de l'app
# User.parent => renvoyer toutes les parents de l'app

# @user = User.first
# @user.nannies => renvoie toutes les nannies avec lesquelles ce user à contracté
# @user.parents => renvoie tous les parents avec lesquelles cette nanny bosse
# @user.parent_contracts => tous les contrats ou le @user est le parent associé
# @user.nanny_contracts => tous les contrats ou le @user est la nanny en question
