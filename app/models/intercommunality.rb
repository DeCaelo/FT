class Intercommunality < ApplicationRecord
  has_many :communes

  validates :name, presence: true
  validates :siren, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A\d{9}\z/ }
  validates :form, inclusion: { in: %w(ca cu cc met) }

  attribute :slug, :string

  after_save { self.slug = self.name.parameterize if self.slug.nil? && !self.name.nil? }

  def communes_hash
    self.communes.map { |c| [(c.code_insee).to_s, c.name] }.to_h
  end

  def population
    self.communes.sum(:population)
  end
end
