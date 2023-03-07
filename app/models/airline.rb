class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights
end
