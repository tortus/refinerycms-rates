require 'spec_helper'

module Refinery
  module Rates
    describe RateTablesHelper do

      describe "#replace_rate_tables" do
        let(:rate_table) { FactoryGirl.create(:rate_table, :content => "test content") }
        it "replaces {{rate_table underscored_slug}} with the rate_table's content surrounded by a container div" do
          content = "{{rate_table #{rate_table.to_param.to_s.underscore}}}"
          helper.replace_rate_tables(content).should == %(<div class="rate_table" id="rate_table_#{rate_table.to_param.to_s.underscore}">#{rate_table.content}</div>)
        end

        it "removes <p> tags around the tag to replace" do
          content = "<p>{{rate_table #{rate_table.to_param.to_s.underscore}}}</p>"
          result = helper.replace_rate_tables(content)
          result.should_not include("<p>")
          result.should_not include("</p>")
        end
      end

    end
  end
end
