# encoding: utf-8
module Refinery
  module Rates
    module RateTablesHelper

      def replace_rate_tables(content)
        content.to_str.gsub(/(?:<p>\s*)?\{\{rate_table\s+([\w\d_]+)}}(?:\s*<\/p>)?/) { |match|
          underscore_url = $1
          url = underscore_url.gsub('_', '-')
          content_tag(:div,
            raw(::Refinery::Rates.content_for(url)),
            :class => 'rate_table',
            :id => "rate_table_#{underscore_url}"
          )
        }
      end

    end
  end
end
