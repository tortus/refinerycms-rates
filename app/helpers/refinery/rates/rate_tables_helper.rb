# encoding: utf-8
module Refinery
  module Rates
    module RateTablesHelper

      def replace_rate_tables(content)
        content.to_str.gsub(/(?:#{Regexp.escape('<p>')})?\{\{rate_table\s+([\w\d_]+)}}(?:#{Regexp.escape('</p>')})?/ { |match|
          url = $1.gsub('_', '-')
          content_tag(:div, ::Refinery::Rates.content_for(url))
        }
      end

    end
  end
end
