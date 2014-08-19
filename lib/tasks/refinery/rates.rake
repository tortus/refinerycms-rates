namespace :refinery do

  namespace :rates do

    desc "change effective date to today"
    task :update_effective_date => :environment do
      effective_date = ::Refinery::Rates::EffectiveDate.singleton
      effective_date.update!(:effective_at => Date.today)
    end

  end

end
