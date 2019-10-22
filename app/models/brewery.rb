class Brewery < ApplicationRecord
  has_many :beers

  scope :alpha, -> {order(:name)}
end
