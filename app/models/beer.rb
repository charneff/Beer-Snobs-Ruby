class Beer < ApplicationRecord
  belongs_to :user
  belongs_to :brewery #creator of Beer
  has_many :reviews
  has_many :users through: :reviews #those who reviewed it

end
