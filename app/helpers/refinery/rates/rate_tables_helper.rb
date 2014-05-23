# encoding: utf-8
module Refinery
  module Rates
    module RateTablesHelper

      def replace_rate_tables(content)
        content.to_str.gsub(/\{\{rate_table\s+([\w\d_]+)}}/) { |match|
          url = $1.gsub('_', '-')
          ::Refinery::Rates.content_for(url)
        }
      end

    end
  end
end
