require 'spec_helper'

module Refinery
  module Rates
    describe RatesHelper do

      describe "#replace_rate_tables" do
        let(:rate_table) { FactoryGirl.create(:rate_table, :content => "<em>test content</em>") }
        it "replaces {{rate_table underscored_slug}} with the rate_table's content surrounded by a container div" do
          content = "{{rate_table #{rate_table.to_param.to_s.underscore}}}"
          helper.replace_rate_tables(content).should == %(<div class="rate_table" id="rate_table_#{rate_table.to_param.to_s.underscore}"><a class="anchor" id="#{rate_table.to_param}"></a>#{rate_table.content}</div>)
        end

        it "removes <p> tags around the tag to replace" do
          content = "<p>{{rate_table #{rate_table.to_param.to_s.underscore}}}</p>"
          result = helper.replace_rate_tables(content)
          result.should_not include("<p>")
          result.should_not include("</p>")
        end

        it "returns nil if content is nil" do
          helper.replace_rate_tables(nil).should == nil
        end

        it "replaces tag with '[Rate table \"url\" not found.]' if rate table doesn't exist" do
          content = "<p>{{rate_table test}}</p>"
          result = helper.replace_rate_tables(content)
          result.should include("[Rate table &quot;test&quot; not found.]")
        end
      end

      describe "#replace_rates_effective_dates" do
        let(:effective_date) { FactoryGirl.create(:effective_date, :effective_at => Date.new(2000, 1, 1)) }
        before do
          EffectiveDate.stub(:singleton) { effective_date }
        end

        it "replaces {{rates_effective_date}} with the current effective date" do
          content = "{{rates_effective_date}}"
          helper.replace_rates_effective_dates(content).should == 'January 1, 2000'
        end

        it "returns nil if content is nil" do
          helper.replace_rate_tables(nil).should == nil
        end

        it "replaces {{rates_effective_date}} with 'N/A' if the effective date is nil for some reason" do
          singleton = double("EffectiveDate", effective_at: nil)
          EffectiveDate.stub(:singleton) { singleton }
          helper.replace_rates_effective_dates("{{rates_effective_date}}").should == "N/A"
        end

        context "when replacement is a Proc" do
          it "replaces {{rates_effective_date}} with the return value of the Proc" do
            replacement = Proc.new { "test" }
            helper.replace_rates_effective_dates("{{rates_effective_date}}", replacement: replacement).should == "test"
          end
          it "passes the EffectiveDate singleton instance to the Proc" do
            effective_date.save
            replacement = Proc.new { |date| "test" }
            replacement.should_receive(:call).with(effective_date).and_return("test")
            helper.replace_rates_effective_dates("{{rates_effective_date}}", replacement: replacement)
          end
        end

        context "when replacement is a String" do
          it "replaces {{rates_effective_date}} with the String" do
            helper.replace_rates_effective_dates("{{rates_effective_date}}", replacement: "test").should == "test"
          end
        end
      end

    end
  end
end
