class ChildContract < ApplicationRecord
  belongs_to :contract
  belongs_to :child
end
