module Refinery
  module Rates
    class EffectiveDate < Refinery::Core::BaseModel
      self.table_name = 'refinery_rates_effective_dates'

      attr_accessible :effective_at

      validates :effective_at, :presence => true

      def inline_replacement_tag
        "{{rates_effective_date}}"
      end

      def rate_table_changed(rate_table)
        update_attributes!(:effective_at => rate_table.updated_at)
      end

      def self.singleton
        first || create!(:effective_at => Time.now)
      end
    end
  end
end
