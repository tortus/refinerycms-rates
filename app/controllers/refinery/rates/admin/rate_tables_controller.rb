module Refinery
  module Rates
    module Admin
      class RateTablesController < ::Refinery::AdminController

        crudify :'refinery/rates/rate_table',
                :xhr_paging => false,
                :order => 'category ASC, title ASC'

      end
    end
  end
end
