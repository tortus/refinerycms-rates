module Refinery
  module Rates
    module RatesHelper

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
        }
      end

      def replace_rates_effective_dates(content)
        effective_at = ::Refinery::Rates::EffectiveDate.singleton.effective_at.strftime('%B %-d, %Y')
        content.to_str.gsub('{{rates_effective_date}}', effective_at)
      end

    end
  end
end
