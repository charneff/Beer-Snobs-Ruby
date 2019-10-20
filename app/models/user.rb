class User < ApplicationRecord
  has_many :reviewed_beers, through: :reviews, source: :beer #beers that they reviewed
  has_many :reviews #created
  has_many :beers #beers they created

end
