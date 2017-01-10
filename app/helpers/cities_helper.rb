module CitiesHelper
  def parse_params url_params
    output_array = []

    params.each do |key, value|
      if key.downcase == "search"
        if value.include?(" ")
          value.split(" ").each do |slugValue|
            output_array << ['slug ilike ?' , "%#{slugValue}%"]
          end
        else
          output_array << ['slug ilike ?' , "%#{value}%"]
        end
      end

      output_array << ['cost_per_month >= ?', value] if key.downcase == "costpermonthfrom"
      output_array << ['cost_per_month <= ?', value] if key.downcase == "costpermonthto"

      output_array << ['population >= ?', value] if key.downcase == "populationfrom"
      output_array << ['population <= ?', value] if key.downcase == "populationto"

      output_array << ['internet_speed >= ?', value] if key.downcase == "internetspeedfrom"
      output_array << ['internet_speed <= ?', value] if key.downcase == "internetspeedto"

      output_array << ['safety >= ?', value] if key.downcase == "safetyfrom"
      output_array << ['nightlife >= ?', value] if key.downcase == "nightlifefrom"
      output_array << ['places_to_work >= ?', value] if key.downcase == "placestoworkfrom"
      output_array << ['fun >= ?', value] if key.downcase == "funfrom"
      output_array << ['english_speaking >= ?', value] if key.downcase == "englishspeakingfrom"
      output_array << ['startup_score >= ?', value] if key.downcase == "startupscorefrom"
      output_array << ['friendly_to_foreigners >= ?', value] if key.downcase == "friendlytoforeignersfrom"
      output_array << ['female_friendly >= ?', value] if key.downcase == "femalefriendlyfrom"
      output_array << ['gay_friendly >= ?', value] if key.downcase == "gayFriendlyfrom"
    end

    output_array
  end

  def parse_params_slugs url_param
    output_array = []

    url_param.each do |value|
      output_array << ['slug ilike ?' , "%#{value}%"]
    end

    output_array
  end

  def setup_from_api_exchange_rates
    begin
      response = RestClient.get('http://api.fixer.io/latest?base=USD', { accept: :json, content_type: :json })
      puts "REST response: #{response.to_json}"
      @exchange_rates = convert_rest_response_to_object JSON.parse(response)
    rescue RestClient::ExceptionWithResponse => err
      @exchange_rates = []
      puts "@exchange_rates(rescue): #{@exchange_rates}"
    end
  end

  def set_property(obj, name, value)
    begin
      obj.send("#{name}=", value)
    rescue NoMethodError => err
      puts "Error:NoMethod: #{err}"
    end
  end

  def convert_rest_response_to_object response
    base_currency = "usd"
    update_date = nil

    base_currency = response["base"] if response.has_key? "base"
    update_date = response["date"] if response.has_key? "date"

    if response.has_key?("rates")
      response["rates"].each do |key, value|
        ecbExchangeRateObject = EcbExchangeRate.find_by(currency_code: key.upcase)

        unless ecbExchangeRateObject.nil?
          ecbExchangeRateObject.base = base_currency
          ecbExchangeRateObject.update_date = update_date
          ecbExchangeRateObject.currency_code = key.downcase
          ecbExchangeRateObject.currency_rate = value
          ecbExchangeRateObject.save!
        end
      end
    end

    EcbExchangeRate.all
  end
end
