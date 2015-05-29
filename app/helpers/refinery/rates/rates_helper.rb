module Refinery
  module Rates
    module RatesHelper

      # Because dates are replaced after rates, it is possible to place the effective date
      # tag within a rate table.
      def replace_rates_tags(content, anchor: true, effective_date: nil, &block)
        replace_rates_effective_dates(
          replace_rate_tables(content, anchor: anchor, &block),
          replacement: effective_date
        )
      end

      def replace_rate_tables(content, anchor: true)
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
              buffer << content_tag(:a, nil, :id => url, :class => "anchor") if anchor
              if rate_table
                buffer << rate_table.content.html_safe
              else
                buffer << %([Rate table "#{url}" not found.])
              end
              buffer
            end
          end

          replacement
        } if content
      end

      def replace_rates_effective_dates(content, replacement: nil)
        if content
          effective_date = ::Refinery::Rates::EffectiveDate.singleton
          if replacement.respond_to?(:call)
            replacement = replacement.call(effective_date)
          elsif !replacement.nil?
            replacement = replacement.to_s
          else
            replacement = effective_date.effective_at.try(:strftime, '%B %-d, %Y') || "N/A"
          end
          replacement ||= ""
          content.to_str.gsub(::Refinery::Rates::EffectiveDate.inline_replacement_tag, replacement)
        end
      end

    end
  end
end
