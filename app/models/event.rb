class Event < ApplicationRecord
  belongs_to :contract
  belongs_to :user
  belongs_to :child
end
