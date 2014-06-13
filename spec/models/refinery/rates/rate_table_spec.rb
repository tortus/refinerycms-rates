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

      describe "#inline_replacement_tag" do
        it "returns {{rate_table underscored_url}} when rate table is persisted" do
          rate_table = FactoryGirl.create(:rate_table, :title => "My Table", :slug => "my-table")
          rate_table.inline_replacement_tag.should == "{{rate_table my_table}}"
        end
        it "returns nil when rate table is not persisted" do
          rate_table = FactoryGirl.build(:rate_table, :title => "My Table", :slug => "my-table")
          rate_table.inline_replacement_tag.should be_nil
        end
      end

      it "update the global effective_date after a change" do
        rate_table = FactoryGirl.create(:rate_table)
        rate_table.content = "changed content"
        EffectiveDate.any_instance.should_receive(:rate_table_changed).with(rate_table)
        rate_table.save!
      end

      it "doesn't raise an exception if EffectiveDate.singleton returns nil" do
        EffectiveDate.stub(:singleton) { nil }
        rate_table = FactoryGirl.build(:rate_table)
        expect { rate_table.save }.not_to raise_error
      end
    end
  end
end
