module Refinery
  module Rates
    class RateTable < Refinery::Core::BaseModel
      extend FriendlyId
      self.table_name = 'refinery_rate_tables'

      attr_accessible :category, :title, :content, :position

      friendly_id :title, :use => [:slugged]
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true, :length => {:maximum => 255}
      validates :category, :length => {:maximum => 255, allow_blank: true}

      after_save :invalidate_cache, :if => lambda { changed? }
      after_save :update_effective_date, :if => lambda { changed? }

      def self.ordered
        order('category ASC, title ASC')
      end

      def inline_replacement_tag
        "{{rate_table #{to_param.to_s.underscore}}}" if persisted?
      end

      CATEGORIES = ['Personal Checking', 'Personal Savings', 'Business Checking', 'Business Savings', 'Dividend Rates', 'Loan Rates', 'Mortgage Rates']

      def category_options
        CATEGORIES
      end

      def invalidate_cache
        Rails.cache.delete([self.class, to_param])
      end

      def self.find_with_cache(url)
        Rails.cache.fetch([::Refinery::Rates::RateTable, url]) {
          ::Refinery::Rates::RateTable.find(url)
        }
      end

      private

        def update_effective_date
          EffectiveDate.singleton.try(:rate_table_changed, self)
        end

    end
  end
end
