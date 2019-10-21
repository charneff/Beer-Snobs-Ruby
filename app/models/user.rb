class User < ApplicationRecord
  has_many :reviews
  has_many :reviewed_beers, through: :reviews, source: :beer
  has_many :beers #that they created

  validates :username, uniqueness: true, presence: true
  has_secure_password

end
