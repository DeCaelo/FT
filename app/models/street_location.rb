class StreetLocation < ApplicationRecord
  belongs_to :street
  belongs_to :commune
end
