module Refinery
  module Rates
    class RateTable < Refinery::Core::BaseModel
      extend FriendlyId
      self.table_name = 'refinery_rate_tables'

      attr_accessible :category, :title, :content, :position

      friendly_id :title, :use => [:slugged]
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :length => {:maximum => 255}
      validates :category, :length => {:maximum => 255, allow_blank: true}

      CATEGORIES = ['Dividend Rates', 'Loan Rates', 'Mortgage Rates']

      def category_options
        CATEGORIES
      end
    end
  end
end
