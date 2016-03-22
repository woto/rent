namespace :rent do
  desc "TODO"
  task withdraw: :environment do
    ActiveRecord::Base.transaction do
      Contract.today_in_range.each do |contract|
        Transaction.create!(contract: contract)
      end
    end
  end
end
