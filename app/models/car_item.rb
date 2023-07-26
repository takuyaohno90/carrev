class CarItem < ApplicationRecord
  belongs_to :maker
  belongs_to :bodytype
  belongs_to :fuel
end
