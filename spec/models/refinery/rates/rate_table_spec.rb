require 'spec_helper'

module Refinery
  module Rates
    describe RateTable do
      describe "validations" do
        subject do
          FactoryGirl.build(:rate_table, :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
