class CityCoworkingPlaceSerializer < BaseSerializer
  attributes :slug, :name, :sub_name, :coworking_type, :distance, :lat, :lng, :data_url, :image_url
end
