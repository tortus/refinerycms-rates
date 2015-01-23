module Refinery
  module Rates
    # Singleton row that that represents the last time that a RateTable
    # was updated. We can't just take updated_at from a RateTable,
    # because sometimes we want to bump this date without actually
    # changing anything.
    #
    # Fetch the global effective datetime for all rates:
    #
    #     Refinery::Rates::EffectiveDate.effective_at
    #
    class EffectiveDate < Refinery::Core::BaseModel
      self.table_name = 'refinery_rates_effective_dates'

      attr_accessible :effective_at

      validates :effective_at, :presence => true

      default_scope lambda { order(:id) }

      def inline_replacement_tag
        "{{rates_effective_date}}"
      end

      def rate_table_changed(rate_table)
        update_attributes!(:effective_at => rate_table.updated_at)
      end

      def self.singleton
        first || create!(:effective_at => Time.zone.now)
      end

      def self.effective_at
        singleton.try(:effective_at)
      end
    end
  end
end
