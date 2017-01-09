class CityCostOfLivingSerializer < BaseSerializer
  attributes :nomad_cost, :expat_cost_of_living, :local_cost_of_living, :one_bedroom_apartment,
    :hotel_room, :airbnb_apartment_month, :airbnb_apartment_day, :coworking_space,
    :coca_cola_in_cafe, :pint_of_beer_in_bar, :cappucino_in_cafe
end
