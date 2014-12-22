module Refinery
  module Rates
    module RatesHelper

      # Because dates are replaced after rates, it is possible to place the effective date
      # tag within a rate table.
      def replace_rates_tags(content, &block)
        replace_rates_effective_dates(replace_rate_tables(content, &block))
      end

      def replace_rate_tables(content)
        content.to_str.gsub(/(?:<p>\s*)?\{\{rate_table\s+([\w\d_]+)}}(?:\s*<\/p>)?/) { |match|
          underscore_url = $1
          url = underscore_url.gsub('_', '-')

          begin
            rate_table = Refinery::Rates::RateTable.find_with_cache(url)
          rescue ActiveRecord::RecordNotFound
            rate_table = nil
          end

          replacement = if block_given?
            yield(rate_table)
          else
            content_tag(:div, :class => 'rate_table', :id => "rate_table_#{underscore_url}") do
              buffer = ActiveSupport::SafeBuffer.new
              buffer << content_tag(:a, nil, :id => url)
              buffer << rate_table.try(:content) || %([Rate table "#{url}" not found.])
              buffer
            end
          end

          replacement
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
