require 'spec_helper'

module Refinery
  module Rates
    describe EffectiveDate do

      subject do
        FactoryGirl.build(:effective_date)
      end

      describe "validations" do
        it { should be_valid }
        its(:errors) { should be_empty }
        its(:effective_at) { should_not be_nil }
      end

      describe "EffectiveDate.singleton" do
        it "returns the first EffectiveDate" do
          effective_date = FactoryGirl.create(:effective_date)
          EffectiveDate.singleton.should == effective_date
        end
        it "creates the first EffectiveDate when none exists" do
          EffectiveDate.first.should be_nil
          expect {
            EffectiveDate.singleton
          }.to change(EffectiveDate, :count).by(1)
        end
      end

      describe "#inline_replacement_tag" do
        it "returns '{{rates_effective_date}}'" do
          subject.inline_replacement_tag.should == "{{rates_effective_date}}"
        end
      end

      describe "#rate_table_changed" do
        it "updates #effective_at with the rate_table's updated_at timestamp" do
          old_date = Time.now - 1.hour
          new_date = Time.now
          effective_date = FactoryGirl.create(:effective_date, :effective_at => old_date)
          rate_table = FactoryGirl.build(:rate_table, :updated_at => new_date)
          expect {
            effective_date.rate_table_changed(rate_table)
          }.to change {
            effective_date.reload.effective_at
          }.from(old_date).to(new_date)
        end
      end

    end
  end
end
