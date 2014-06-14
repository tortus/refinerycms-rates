module Refinery
  module Rates
    module Admin
      class RateTablesController < ::Refinery::AdminController

        before_filter :find_effective_date

        crudify :'refinery/rates/rate_table',
                :paging => false,
                :order => 'category ASC, title ASC',
                :sortable => false

        private

          def find_effective_date
            @effective_date = EffectiveDate.singleton
          end

      end
    end
  end
end
