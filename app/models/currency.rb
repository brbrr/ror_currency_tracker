class Currency < ApplicationRecord
  self.primary_key = :code

  validates :name, :code, :weight, :collector_value, presence: true
  validates :code, uniqueness: true

  belongs_to :country

  def self.collected
    all.select(&:collected?)
  end

  def self.not_collected
    all.reject(&:collected?)
  end

  def collected?
    country.nil? ? false : country.visited?
  end
end
