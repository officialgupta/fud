require 'csv'
require 'chronic_duration'

namespace :import do
  desc "TODO"
  task food: :environment do
    Food.delete_all
    csv_text = File.read("#{Rails.root}/data/FoodKeeper-Data.csv").encode('UTF-8', :invalid => :replace)
    csv = CSV.parse(csv_text, :headers => true)
    type = "nil"
    csv.each do |row|
      if row.to_hash["Category_ID"] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        case row.to_hash["Category_ID"].to_i
          when 1
            type = "Baby Food"
          when 2..4
            type = "Baked Goods"
          when 5
            type = "Beverages"
          when 6
            type = "Condiments & Sauces"
          when 7
            type = "Dairy Products & Eggs"
          when 8
            type = "Food Purchased Frozen"
          when 9
            type = "Grains, Beans & Pasta"
          when 10..13
            type = "Grains, Beans & Pasta"
          when 14..17
            type = "Poultry"
          when 18
            type = "Fruits"
          when 19
            type = "Vegetables"
          when 20..22
            type = "Seafood"
          when 23
            type = "Preserved"
          when 24
            type = "Vegetarian Proteins"
          when 25
            type = "Deli & Prepared Foods"
          else
            type = "Miscellaneous"
        end
        begin
          if ChronicDuration.parse(row.to_hash["Refrigerate Output [Display ONLY!]"]).present?
            expire = ChronicDuration.parse(row.to_hash["Refrigerate Output [Display ONLY!]"])
          elsif ChronicDuration.parse(row.to_hash["Freeze Output  [Display ONLY!]"]).present?
            expire = ChronicDuration.parse(row.to_hash["Freeze Output  [Display ONLY!]"])
          elsif ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"]).present?
            expire = ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"])
          else
            expire = ChronicDuration.parse(row.to_hash["Pantry After Opening Output [Display ONLY!]"])
          end
        rescue
          expire = ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"])
        end

        begin
           expire /= 86400
        rescue
          expire = 9001
        end
        puts "#{row.to_hash["Name"]}  #{row.to_hash["Name_subtitle"]} - #{type} - #{expire}"
        begin
          Food.create!(food_type: type, name: "#{row.to_hash["Name"]} #{row.to_hash["Name_subtitle"]}", time_to_expire_in_days: expire)
        rescue
          # Do nothing
        end
      end
    end
  end

end
