# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

work_directory = "db/"
csv_text = File.read(work_directory + "csvs/city_data_input.csv")
csv = CSV.parse(csv_text, headers: false, col_sep: "|")

base_currency = 'USD'
currencies = [ 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'GBP', 'HKD', 'HRK', 'HUF',
'IDR', 'ILS', 'INR', 'JPY', 'KRW', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB',
'SEK', 'SGD', 'THB', 'TRY', 'ZAR', 'EUR' ]

currencies.each do |currency|
  currencyRate = EcbExchangeRate.new
  currencyRate.base = base_currency
  currencyRate.currency_code = currency
  currencyRate.save!
end

csv.each do |row|
  filename_info = work_directory + "/csvs/" + row[1] + ".info"
  filename_image = work_directory + "/images/" + row[3]
  filename_coworking = work_directory + "/csvs/" + row[1] + ".coworking"

  if File.file?(filename_info)
    puts "cslug:#{row[1]}"
    line_num = 0

    city = City.new
    cityScore = CityScore.new
    cityCostOfLiving = CityCostOfLiving.new

    File.open(filename_info).each do |fileLine|
      if line_num <= 41
        lineValues = fileLine.split(':')

        if lineValues.size == 2
          title = lineValues[0]
          value = lineValues[1].sub("\n", "")

          # City
          city.data_id = value if title == 'dataId'
          city.slug = value if title == 'dataSlug'
          city.region = value if title == 'region'
          city.country = value if title == 'country'
          city.temperature_c = value if title == 'temperatureC'
          city.temperature_f = value if title == 'temperatureF'
          city.humidity = value if title == 'humidity'
          city.rank = value if title == 'rank'
          city.cost_per_month = value if title == 'costPerMonth'
          city.internet_speed = value if title == 'internetSpeed'
          city.population = value if title == 'population'
          city.gender_ratio = value if title == 'genderRatio'
          city.religious = value if title == 'religious'
          city.city_currency = value if title == 'cityCurrency'

          # CityScore
          cityScore.nomad_score = value if title == 'nomadScore'
          cityScore.life_score = value if title == 'lifeScore'
          cityScore.cost = value if title == 'cost'
          cityScore.internet = value if title == 'internet'
          cityScore.fun = value if title == 'fun'
          cityScore.safety = value if title == 'safety'
          cityScore.peace = value if title == 'peace'
          cityScore.nightlife = value if title == 'nightlife'
          cityScore.free_wifi_in_city = value if title == 'freeWifiInCity'
          cityScore.places_to_work = value if title == 'placesToWorkFrom'
          cityScore.ac_or_heating = value if title == 'acOrHeating'
          cityScore.friendly_to_foreigners = value if title == 'friendlyToForeigners'
          cityScore.female_friendly = value if title == 'femaleFriendly'
          cityScore.gay_friendly = value if title == 'gayFriendly'
          cityScore.startup_score = value if title == 'startupScore'
          cityScore.english_speaking = value if title == 'englishSpeaking'

          # CityCostOfLiving
          cityCostOfLiving.nomad_cost = value if title == 'nomadCost'
          cityCostOfLiving.expat_cost_of_living = value if title == 'expatCostOfLiving'
          cityCostOfLiving.local_cost_of_living = value if title == 'localCostOfLiving'
          cityCostOfLiving.one_bedroom_apartment = value if title == 'oneBedroomApartment'
          cityCostOfLiving.hotel_room = value if title == 'hotelRoom'
          cityCostOfLiving.airbnb_apartment_month = value if title == 'airbnbApartmentMonth'
          cityCostOfLiving.airbnb_apartment_day = value if title == 'airbnbApartmentDay'
          cityCostOfLiving.coworking_space = value if title == 'coworkingSpace'
          cityCostOfLiving.coca_cola_in_cafe = value if title == 'cocaColaInCafe'
          cityCostOfLiving.pint_of_beer_in_bar = value if title == 'pintOfBeerInBar'
          cityCostOfLiving.cappucino_in_cafe = value if title == 'cappucinoInCafe'
        end
      end

      line_num = line_num + 1
    end

    if File.file?(filename_coworking)
      File.open(filename_coworking).each do |fileLine|
        values = fileLine.split('|')

        if values.size != 0
          puts "slug:#{values[0]}"
          cityCoworkingPlace = CityCoworkingPlace.new
          cityCoworkingPlace.slug = values[0]
          cityCoworkingPlace.name = values[1]
          cityCoworkingPlace.sub_name = values[2]
          cityCoworkingPlace.coworking_type = values[3]
          cityCoworkingPlace.distance = values[4]
          cityCoworkingPlace.lat = values[5]
          cityCoworkingPlace.lng = values[6]
          cityCoworkingPlace.data_url = values[7]
          cityCoworkingPlace.image_url = values[8].sub("\n", "")
          cityCoworkingPlace.save!

          city.city_coworking_places << cityCoworkingPlace
        end
      end
    end

    if File.file?(filename_image)
      city.image = Rails.root.join(filename_image).open
    end

    cityScore.save!
    cityCostOfLiving.save!

    city.city_score = cityScore
    city.city_cost_of_living = cityCostOfLiving
    city.ecb_exchange_rate = EcbExchangeRate.find_by(currency_code: city.city_currency)

    city.save!
  end
end
