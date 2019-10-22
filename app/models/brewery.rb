class Brewery < ApplicationRecord
  has_many :beers

  scope :alpha, -> {order(:name)}

  def name_and_location
    "#{name} - #{location}"
  end
end
