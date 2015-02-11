namespace :refinery do

  namespace :rates do

    desc "change effective date to today"
    task :update_effective_date => :environment do
      effective_date = ::Refinery::Rates::EffectiveDate.singleton
      effective_date.update_attributes!(:effective_at => Time.zone.today)
    end

    desc "invalidate cache"
    task :invalidate_cache => :environment do
      ::Refinery::Rates::RateTable.find_each do |rate_table|
        rate_table.invalidate_cache
      end
    end

  end

end
