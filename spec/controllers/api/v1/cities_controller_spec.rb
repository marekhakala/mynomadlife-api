require 'rails_helper'

RSpec.describe 'Cities API', type: :request do
  describe 'GET /api/v1/cities' do
    before { get api_v1_cities_path }

    it 'when the basic info is correct' do
      expect(json_response[:total_entries]).to eq(2)
      expect(json_response[:total_pages]).to eq(1)
      expect(json_response[:per_page]).to eq(50)
      expect(json_response[:current_page]).to eq(1)
      expect(json_response[:entries].length).to eq(2)
    end

    it 'when the first city entry is Prague' do
      city_entry = json_response[:entries][0]
      expect(city_entry[:slug]).to eq("prague-czech-republic")
      expect(city_entry[:region]).to eq("Prague")
      expect(city_entry[:country]).to eq("Czech Republic")
      expect(city_entry[:temperature_c]).to eq(1)
      expect(city_entry[:temperature_f]).to eq(31)
      expect(city_entry[:humidity]).to eq(89)
      expect(city_entry[:rank]).to eq(45)
      expect(city_entry[:cost_per_month]).to eq("872.0")
      expect(city_entry[:internet_speed]).to eq(50)
      expect(city_entry[:population]).to eq("1000000.0")
      expect(city_entry[:gender_ratio]).to eq("102.99/100")
      expect(city_entry[:religious]).to eq("Free (secular)")
      expect(city_entry[:city_currency]).to eq("CZK")
      expect(city_entry[:city_currency_rate]).not_to be_empty
    end

    it 'when the first city entry is Prague with scores' do
      city_entry_scores = json_response[:entries][0][:scores]

      expect(city_entry_scores[:nomad_score]).to eq("7.1")
      expect(city_entry_scores[:life_score]).to eq("8.4")
      expect(city_entry_scores[:cost]).to eq(5)
      expect(city_entry_scores[:internet]).to eq(5)
      expect(city_entry_scores[:fun]).to eq(5)
      expect(city_entry_scores[:safety]).to eq(4)
      expect(city_entry_scores[:peace]).to eq(4)
      expect(city_entry_scores[:nightlife]).to eq(5)
      expect(city_entry_scores[:free_wifi_in_city]).to eq(3)
      expect(city_entry_scores[:places_to_work]).to eq(5)
      expect(city_entry_scores[:ac_or_heating]).to eq(3)
      expect(city_entry_scores[:friendly_to_foreigners]).to eq(4)
      expect(city_entry_scores[:female_friendly]).to eq(5)
      expect(city_entry_scores[:gay_friendly]).to eq(3)
      expect(city_entry_scores[:startup_score]).to eq("7.1")
      expect(city_entry_scores[:english_speaking]).to eq(3)
    end

    it 'when the first city entry is Prague with cost of living' do
      city_entry_cost_of_living = json_response[:entries][0][:cost_of_living]

      expect(city_entry_cost_of_living[:nomad_cost]).to eq("876.0")
      expect(city_entry_cost_of_living[:expat_cost_of_living]).to eq("1291.0")
      expect(city_entry_cost_of_living[:local_cost_of_living]).to eq("524.0")
      expect(city_entry_cost_of_living[:one_bedroom_apartment]).to eq("398.0")
      expect(city_entry_cost_of_living[:hotel_room]).to eq("303.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_month]).to eq("2848.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_day]).to eq("93.0")
      expect(city_entry_cost_of_living[:coworking_space]).to eq("159.0")
      expect(city_entry_cost_of_living[:coca_cola_in_cafe]).to eq("0.73")
      expect(city_entry_cost_of_living[:pint_of_beer_in_bar]).to eq("1.99")
      expect(city_entry_cost_of_living[:cappucino_in_cafe]).to eq("1.33")
    end

    it 'when the second city entry is Berlin' do
      city_entry = json_response[:entries][1]

      expect(city_entry[:slug]).to eq("berlin-germany")
      expect(city_entry[:region]).to eq("Berlin")
      expect(city_entry[:country]).to eq("Germany")
      expect(city_entry[:temperature_c]).to eq(2)
      expect(city_entry[:temperature_f]).to eq(35)
      expect(city_entry[:humidity]).to eq(100)
      expect(city_entry[:rank]).to eq(280)
      expect(city_entry[:cost_per_month]).to eq("2323.0")
      expect(city_entry[:internet_speed]).to eq(25)
      expect(city_entry[:population]).to eq("3501872.0")
      expect(city_entry[:gender_ratio]).to eq("105/100")
      expect(city_entry[:religious]).to eq("Free (secular)")
      expect(city_entry[:city_currency]).to eq("EUR")
    end

    it 'when the second city entry is Berlin with scores' do
      city_entry_scores = json_response[:entries][1][:scores]

      expect(city_entry_scores[:nomad_score]).to eq("6.1")
      expect(city_entry_scores[:life_score]).to eq("8.5")
      expect(city_entry_scores[:cost]).to eq(4)
      expect(city_entry_scores[:internet]).to eq(4)
      expect(city_entry_scores[:fun]).to eq(5)
      expect(city_entry_scores[:safety]).to eq(5)
      expect(city_entry_scores[:peace]).to eq(5)
      expect(city_entry_scores[:nightlife]).to eq(5)
      expect(city_entry_scores[:free_wifi_in_city]).to eq(5)
      expect(city_entry_scores[:places_to_work]).to eq(4)
      expect(city_entry_scores[:ac_or_heating]).to eq(5)
      expect(city_entry_scores[:friendly_to_foreigners]).to eq(5)
      expect(city_entry_scores[:female_friendly]).to eq(5)
      expect(city_entry_scores[:gay_friendly]).to eq(5)
      expect(city_entry_scores[:startup_score]).to eq("9.8")
      expect(city_entry_scores[:english_speaking]).to eq(5)
    end

    it 'when the second city entry is Berlin with cost of living' do
      city_entry_cost_of_living = json_response[:entries][1][:cost_of_living]

      expect(city_entry_cost_of_living[:nomad_cost]).to eq("2334.0")
      expect(city_entry_cost_of_living[:expat_cost_of_living]).to eq("1726.0")
      expect(city_entry_cost_of_living[:local_cost_of_living]).to eq("1064.0")
      expect(city_entry_cost_of_living[:one_bedroom_apartment]).to eq("753.0")
      expect(city_entry_cost_of_living[:hotel_room]).to eq("2132.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_month]).to eq("2343.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_day]).to eq("77.0")
      expect(city_entry_cost_of_living[:coworking_space]).to eq("172.0")
      expect(city_entry_cost_of_living[:coca_cola_in_cafe]).to eq("2.15")
      expect(city_entry_cost_of_living[:pint_of_beer_in_bar]).to eq("4.3")
      expect(city_entry_cost_of_living[:cappucino_in_cafe]).to eq("3.23")
    end
  end

  describe 'GET /api/v1/cities/:slug' do
    before { get api_v1_city_path("berlin-germany") }

    it 'when the city entry is Berlin' do
      city_entry = json_response

      expect(city_entry[:slug]).to eq("berlin-germany")
      expect(city_entry[:region]).to eq("Berlin")
      expect(city_entry[:country]).to eq("Germany")
      expect(city_entry[:temperature_c]).to eq(2)
      expect(city_entry[:temperature_f]).to eq(35)
      expect(city_entry[:humidity]).to eq(100)
      expect(city_entry[:rank]).to eq(280)
      expect(city_entry[:cost_per_month]).to eq("2323.0")
      expect(city_entry[:internet_speed]).to eq(25)
      expect(city_entry[:population]).to eq("3501872.0")
      expect(city_entry[:gender_ratio]).to eq("105/100")
      expect(city_entry[:religious]).to eq("Free (secular)")
      expect(city_entry[:city_currency]).to eq("EUR")
    end

    it 'when the city entry is Berlin with scores' do
      city_entry_scores = json_response[:scores]

      expect(city_entry_scores[:nomad_score]).to eq("6.1")
      expect(city_entry_scores[:life_score]).to eq("8.5")
      expect(city_entry_scores[:cost]).to eq(4)
      expect(city_entry_scores[:internet]).to eq(4)
      expect(city_entry_scores[:fun]).to eq(5)
      expect(city_entry_scores[:safety]).to eq(5)
      expect(city_entry_scores[:peace]).to eq(5)
      expect(city_entry_scores[:nightlife]).to eq(5)
      expect(city_entry_scores[:free_wifi_in_city]).to eq(5)
      expect(city_entry_scores[:places_to_work]).to eq(4)
      expect(city_entry_scores[:ac_or_heating]).to eq(5)
      expect(city_entry_scores[:friendly_to_foreigners]).to eq(5)
      expect(city_entry_scores[:female_friendly]).to eq(5)
      expect(city_entry_scores[:gay_friendly]).to eq(5)
      expect(city_entry_scores[:startup_score]).to eq("9.8")
      expect(city_entry_scores[:english_speaking]).to eq(5)
    end

    it 'when the city entry is Berlin with cost of living' do
      city_entry_cost_of_living = json_response[:cost_of_living]

      expect(city_entry_cost_of_living[:nomad_cost]).to eq("2334.0")
      expect(city_entry_cost_of_living[:expat_cost_of_living]).to eq("1726.0")
      expect(city_entry_cost_of_living[:local_cost_of_living]).to eq("1064.0")
      expect(city_entry_cost_of_living[:one_bedroom_apartment]).to eq("753.0")
      expect(city_entry_cost_of_living[:hotel_room]).to eq("2132.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_month]).to eq("2343.0")
      expect(city_entry_cost_of_living[:airbnb_apartment_day]).to eq("77.0")
      expect(city_entry_cost_of_living[:coworking_space]).to eq("172.0")
      expect(city_entry_cost_of_living[:coca_cola_in_cafe]).to eq("2.15")
      expect(city_entry_cost_of_living[:pint_of_beer_in_bar]).to eq("4.3")
      expect(city_entry_cost_of_living[:cappucino_in_cafe]).to eq("3.23")
    end
  end

  describe 'GET /api/v1/cities/:city_slug/coworking' do
    before { get api_v1_city_coworking_path("berlin-germany") }

    it 'when the basic info is correct' do
      expect(json_response[:total_entries]).to eq(113)
      expect(json_response[:entries].length).to eq(json_response[:total_entries])
    end

    it 'when the 4th coworking entry is Betahaus' do
      city_entry = json_response[:entries][2]

      expect(city_entry[:slug]).to eq("betahaus-prinzessinnenstrasse-19-20-berlin")
      expect(city_entry[:name]).to eq("Betahaus")
      expect(city_entry[:sub_name]).to eq("Prinzessinnenstrasse 19-20")
      expect(city_entry[:coworking_type]).to eq("coworking")
      expect(city_entry[:distance]).to eq("2 km")
      expect(city_entry[:lat]).to eq("52.5025407")
      expect(city_entry[:lng]).to eq("13.4121985")
      expect(city_entry[:data_url]).to eq("https://www.coworker.com/germany/kreuzberg/betahaus")
      expect(city_entry[:image_url]).to eq("https://coworker-media.s3.amazonaws.com/photos/germany/kreuzberg/betahaus/main.jpg")
    end
  end

  describe 'GET /api/v1/cities/:city_slug/image' do
    before { get api_v1_city_image_path("berlin-germany") }

    it 'when the image is set correctly' do
      expect(response.header["Content-Type"]).to eq("image/jpeg")
    end
  end

  describe 'GET /api/v1/exchange_rates' do
    before { get api_v1_exchange_rates_path }

    it 'when the array include 31 exchange rates' do
      expect(json_response[:exchange_rates].length).to eq(31)
    end

    it 'when the first exchange rate is set correctly' do
      first_exchange_rate = json_response[:exchange_rates][0]
      expect(first_exchange_rate[:base]).to eq("USD")
      expect(first_exchange_rate[:currency_code]).to eq("aud")
      expect(first_exchange_rate[:currency_rate]).not_to be_empty
    end
  end
end
