class CreateCityCostOfLivings < ActiveRecord::Migration[5.0]
  def change
    create_table :city_cost_of_livings do |t|
      t.decimal :nomad_cost
      t.decimal :expat_cost_of_living
      t.decimal :local_cost_of_living
      t.decimal :one_bedroom_apartment
      t.decimal :hotel_room
      t.decimal :airbnb_apartment_month
      t.decimal :airbnb_apartment_day
      t.decimal :coworking_space
      t.decimal :coca_cola_in_cafe
      t.decimal :pint_of_beer_in_bar
      t.decimal :cappucino_in_cafe

      t.timestamps
    end
  end
end
