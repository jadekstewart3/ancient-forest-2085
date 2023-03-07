require 'rails_helper'
RSpec.describe 'Flights Index Page' do
  describe 'As a visitor' do
    before (:each) do
      @frontier = Airline.create!(name: "Frontier")
      @spirit = Airline.create!(name: "Spirit")
      @flight_1 = @frontier.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @spirit.flights.create!(number: "1328", date: "08/03/20", departure_city: "Denver", arrival_city: "Tampa")
      @jade = @flight_1.passengers.create!(name: "Jade", age: 24)
      @hannah = @flight_2.passengers.create!(name: "Hannah", age: 24)
      visit flights_path
    end
    context 'When I visit the flights index page' do
      it 'I see a list of all flight numbers, the airline, and the passengers for that flight' do
       
        within "#flight-#{@flight_1.id}" do 
          expect(page).to have_content("Airline: #{@frontier.name}")
          expect(page).to have_content("Flight number: #{@flight_1.number}")
          expect(page).to have_content("Passengers:\n#{@jade.name}")
        end

        within "#flight-#{@flight_2.id}" do 
          expect(page).to have_content("Airline: #{@spirit.name}")
          expect(page).to have_content("Flight number: #{@flight_2.number}")
          expect(page).to have_content("Passengers:\n#{@hannah.name}")
        end
      end
    end
  end
end