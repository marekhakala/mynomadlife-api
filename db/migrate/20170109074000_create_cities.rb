class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.integer :data_id, null: false
      t.string :slug, unique: true, index: true
      t.string :region, index: true
      t.string :country, index: true
      t.integer :temperature_c
      t.integer :temperature_f
      t.integer :humidity
      t.integer :rank
      t.decimal :cost_per_month
      t.integer :internet_speed
      t.decimal :population
      t.string :gender_ratio
      t.string :religious
      t.string :city_currency
      t.string :image, null: true

      t.references :city_score, index: true, foreign_key: true
      t.references :city_cost_of_living, index: true, foreign_key: true
      t.references :ecb_exchange_rate, index: true, foreign_key: true

      t.timestamps
    end
  end
end
