class Street < ApplicationRecord
  has_many :street_locations
  has_many :communes, through: :street_locations

  validates :title, presence: true
  validates :from, numericality: { allow_nil: true }
  validates :to, numericality: { greater_than: :from, allow_nil: true }
end
