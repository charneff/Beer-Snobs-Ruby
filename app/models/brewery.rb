class Brewery < ApplicationRecord
  has_many :beers
  has_many :reviews, through: :beers
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true

  scope :alpha, -> {order(:name)}

  def name_and_location
    "#{name} - #{location}"
  end
end
