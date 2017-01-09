class CreateCityScores < ActiveRecord::Migration[5.0]
  def change
    create_table :city_scores do |t|
      t.decimal :nomad_score
      t.decimal :life_score
      t.integer :cost
      t.integer :internet
      t.integer :fun
      t.integer :safety
      t.integer :peace
      t.integer :nightlife
      t.integer :free_wifi_in_city
      t.integer :places_to_work
      t.integer :ac_or_heating
      t.integer :friendly_to_foreigners
      t.integer :female_friendly
      t.integer :gay_friendly
      t.decimal :startup_score
      t.integer :english_speaking

      t.timestamps
    end
  end
end
