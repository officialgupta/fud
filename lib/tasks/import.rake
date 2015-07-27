require 'csv'

namespace :import do
  desc "TODO"
  task foodbanks: :environment do
    if Foodbank.all.empty?
      csv_text = File.read("#{Rails.root}/data/foodbanks.csv")
      csv = CSV.parse(csv_text)

      csv.each do |foodbank_data|
        Foodbank.create(company: foodbank_data[0],
                        county: foodbank_data[1],
                        name: foodbank_data[2],
                        contact: foodbank_data[3])
        puts "#{Foodbank.last.name} has been added to the database"
      end
    end
  end
end
