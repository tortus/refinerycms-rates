module Refinery
  module Rates
    class RateTablesController < ::ApplicationController

      before_filter :find_all_rate_tables
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @rate in the line below:
        present(@page)
      end

      def show
        @rate_table = RateTable.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @rate in the line below:
        present(@page)
      end

    protected

      def find_all_rate_tables
        @rate_tables = RateTable.ordered
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/rates").first
      end

    end
  end
end
