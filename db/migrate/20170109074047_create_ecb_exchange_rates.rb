class CreateEcbExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :ecb_exchange_rates do |t|
      t.string :base
      t.date :update_date
      t.string :currency_code, index: true, unique: true
      t.decimal :currency_rate

      t.timestamps
    end
  end
end
