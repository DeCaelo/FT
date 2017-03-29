class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: true
  has_many :street_locations
  has_many :streets, through: :street_locations

  validates :name, presence: true
  validates :code_insee, presence: true, length: { is: 5 }

  def self.search(search)
    where('LOWER(name) LIKE ?', "%#{sanitize_sql_like(search.mb_chars.downcase)}%")
  end

  def self.to_hash
    all.map { |c| [(c.code_insee).to_s, c.name] }.to_h
  end
end
