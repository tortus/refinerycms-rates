module Refinery
  module Rates
    module Admin
      class EffectiveDatesController < ::Refinery::AdminController

        before_filter :find_effective_date

        def show
          redirect_to refinery.edit_rates_admin_effective_date_url
        end

        def edit
        end

        def update
          if @effective_date.update_attributes(params[:effective_date])
            redirect_to refinery.rates_admin_root_url, :notice => "Effective date was successfully updated."
          else
            render :action => :edit
          end
        end

        private

          def find_effective_date
            @effective_date = EffectiveDate.singleton
          end

      end
    end
  end
end
