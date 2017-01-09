class CitySerializer < BaseSerializer
  attributes :slug, :region, :country, :temperature_c, :temperature_f,
    :humidity, :rank, :cost_per_month, :internet_speed, :population, :gender_ratio,
    :religious, :city_currency, :city_currency_rate, :scores, :cost_of_living, :image

  def scores
    resolve_reference object.city_score
  end

  def cost_of_living
    resolve_reference object.city_cost_of_living
  end

  def city_currency_rate
    unless object.ecb_exchange_rate.nil?
      resolve_reference object.ecb_exchange_rate.currency_rate
    else
      nil
    end
  end

  def image
    object.image_path
  end
end
