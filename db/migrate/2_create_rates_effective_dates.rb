class CreateRatesEffectiveDates < ActiveRecord::Migration

  def up
    create_table :refinery_rates_effective_dates do |t|
      t.datetime :effective_at
      t.timestamps
    end
  end

  def down
    drop_table :refinery_rates_effective_dates
  end

end
