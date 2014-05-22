class CreateRatesRateTables < ActiveRecord::Migration

  def up
    create_table :refinery_rate_tables do |t|
      t.string :title
      t.string :category
      t.text :content
      t.string :slug
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-rates"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/rates"})
    end

    drop_table :refinery_rate_tables

  end

end
