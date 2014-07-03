class AddIndexToRateTablesSlug < ActiveRecord::Migration

  def change
    add_index :refinery_rate_tables, :slug
  end

end
