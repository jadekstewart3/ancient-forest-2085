require 'rails_helper'
RSpec.describe 'Flights Index Page' do
  describe 'As a visitor' do
    before (:each) do
      @frontier = Airline.create!(name: "Frontier")
      @spirit = Airline.create!(name: "Spirit")
      @flight_1 = @frontier.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight_2 = @spirit.flights.create!(number: "1328", date: "08/03/20", departure_city: "Denver", arrival_city: "Tampa")
      @jade = Passenger.create!(name: "Jade", age: 24)
      @hannah = Passenger.create!(name: "Hannah", age: 24)
      PassengerFlight.create!(flight: @flight_1, passenger: @jade)
      PassengerFlight.create!(flight: @flight_2, passenger: @jade)
      PassengerFlight.create!(flight: @flight_2, passenger: @hannah)
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
          expect(page).to have_content("#{@jade.name}")
          expect(page).to have_content("#{@hannah.name}")
        end
      end

      it 'next to each passengers name I see a link to remove that passenger from that flight' do
        expect(page).to have_button("Remove #{@jade.name} from #{@flight_1.number}")
        expect(page).to have_button("Remove #{@jade.name} from #{@flight_2.number}")
        expect(page).to have_button("Remove #{@hannah.name} from #{@flight_2.number}")
      end

      it 'when I click the button I am returned to the flights index page and I no longer see that passenger listed under that flight' do
        within "#flight-#{@flight_1.id}" do
          click_button "Remove #{@jade.name} from #{@flight_1.number}"
        
          expect(page).to_not have_content("Jade")
          expect(current_path).to eq(flights_path)
        end

        within "#flight-#{@flight_2.id}" do
          expect(page).to have_content("Hannah")
          expect(page).to have_content("Jade")
        end
      end
    end
  end
end