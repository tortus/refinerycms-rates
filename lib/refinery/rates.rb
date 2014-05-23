require 'refinerycms-core'

module Refinery
  autoload :RatesGenerator, 'generators/refinery/rates_generator'

  module Rates
    require 'refinery/rates/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end

      # Shortcut to insert a rate table in a template using ruby code,
      # in a way that will make any errors apparent without throwing
      # an exception.
      #
      #     <%= Refinery::Rates.content_for('auto-loans') %>
      #
      def content_for(url)
        begin
          rate_table = Rails.cache.fetch([::Refinery::Rates::RateTable, url]) {
            ::Refinery::Rates::RateTable.find(url)
          }
          rate_table.content
        rescue ::ActiveRecord::RecordNotFound
          %([Rate table "#{url}" not found.])
        end
      end

    end
  end
end
