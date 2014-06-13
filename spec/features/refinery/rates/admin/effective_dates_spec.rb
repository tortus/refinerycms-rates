# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Rates" do
    describe "Admin" do
      describe "effective_dates" do
        refinery_login_with :refinery_user

        describe "viewing rates admin index" do
          let(:effective_date) { ::Refinery::Rates::EffectiveDate.singleton }

          it "shows the effective date" do
            visit refinery.rates_admin_rate_tables_path
            page.should have_content("Effective date: #{effective_date.effective_at.to_s}")
          end
        end

      end
    end
  end
end
