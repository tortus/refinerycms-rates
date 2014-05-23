module Refinery
  module Rates
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Rates

      engine_name :refinery_rates

      before_inclusion do
        ::ApplicationController.send :helper, Refinery::Rates::RateTablesHelper
        Refinery::AdminController.send :helper, Refinery::Rates::RateTablesHelper
      end

      initializer "refinery.rates register plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "rates"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.rates_admin_rate_tables_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/rates/rate_table'
          }

        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Rates)
      end
    end
  end
end
