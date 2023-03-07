class PassengerFlightsController < ApplicationController

  def destroy
    passenger_flight = PassengerFlight.find_by(flight_id: params[:id], passenger_id: params[:passenger_id])
    passenger_flight.destroy
    redirect_to flights_path
  end
end
