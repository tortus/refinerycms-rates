# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Rates" do
    describe "Admin" do
      describe "effective_dates" do
        refinery_login_with :refinery_user

        let(:effective_date) { ::Refinery::Rates::EffectiveDate.singleton }
        let(:effective_date_link_text) { "Effective date: #{effective_date.effective_at.strftime('%B %-d, %Y')}" }

        describe "viewing rates admin index" do
          it "shows the effective date" do
            visit refinery.rates_admin_rate_tables_path
            page.should have_content(effective_date_link_text)
          end
        end

        describe "editing the effective date" do
          before do
            visit refinery.rates_admin_rate_tables_path
            click_link effective_date_link_text
          end

          it "should succeed" do
            fill_in "Effective at", with: Time.now
            click_button "Save"

            page.should have_content("Effective date was successfully updated.")
          end
        end

      end
    end
  end
end
