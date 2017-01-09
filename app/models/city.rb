class City < ApplicationRecord
  belongs_to :city_score
  belongs_to :city_cost_of_living
  belongs_to :ecb_exchange_rate, optional: true
  has_many :city_coworking_places
  mount_uploader :image, ImageUploader

  def image_path
    ActionController::Base.helpers.asset_path(self.slug + ".jpg")
  end
end
