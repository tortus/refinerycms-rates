module Refinery
  module Rates
    class RateTable < Refinery::Core::BaseModel
      self.table_name = 'refinery_rate_tables'

      attr_accessible :category, :title, :content, :position

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :length => {:maximum => 255}
      validates :category, :length => {:maximum => 255, allow_blank: true}
    end
  end
end
