class CreatePassengerFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :passenger_flights do |t|
      t.references :flight, foreign_key: true
      t.references :passenger, foreign_key: true

      t.timestamps
    end
  end
end
