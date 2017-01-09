class CityScoreSerializer < BaseSerializer
  attributes :nomad_score, :life_score, :cost, :internet, :fun, :safety,
    :peace, :nightlife, :free_wifi_in_city, :places_to_work, :ac_or_heating, :friendly_to_foreigners,
    :female_friendly, :gay_friendly, :startup_score, :english_speaking
end
