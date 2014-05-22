module Refinery
  module Rates
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Rates

      engine_name :refinery_rates

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "rates"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.rates_admin_rates_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/rates/rate'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Rates)
      end
    end
  end
end
