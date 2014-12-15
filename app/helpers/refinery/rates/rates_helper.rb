module Refinery
  module Rates
    module RatesHelper

      # Because dates are replaced after rates, it is possible to place the effective date
      # tag within a rate table.
      def replace_rates_tags(content)
        replace_rates_effective_dates(replace_rate_tables(content))
      end

      def replace_rate_tables(content)
        content.to_str.gsub(/(?:<p>\s*)?\{\{rate_table\s+([\w\d_]+)}}(?:\s*<\/p>)?/) { |match|
          underscore_url = $1
          url = underscore_url.gsub('_', '-')
          content_tag(:div,
            raw(::Refinery::Rates.content_for(url)),
            :class => 'rate_table',
            :id => "rate_table_#{underscore_url}"
          )
        } if content
      end

      def replace_rates_effective_dates(content)
        if content
          effective_at = ::Refinery::Rates::EffectiveDate.singleton.effective_at.try(:strftime, '%B %-d, %Y') || "N/A"
          content.to_str.gsub('{{rates_effective_date}}', effective_at)
        end
      end

    end
  end
end
