class CreateCityCoworkingPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :city_coworking_places do |t|
      t.string :slug
      t.string :name
      t.string :sub_name
      t.string :coworking_type
      t.string :distance
      t.string :lat
      t.string :lng
      t.string :data_url
      t.string :image_url
      t.references :city, index: true, foreign_key: true

      t.timestamps
    end
  end
end
