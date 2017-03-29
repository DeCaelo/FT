class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: true
  has_many :street_locations
  has_many :streets, through: :street_locations

  validates :name, presence: true
  validates :code_insee, presence: true, length: { is: 5 }
end
