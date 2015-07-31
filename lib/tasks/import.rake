require 'csv'
require 'chronic_duration'
require 'json'

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

  task food: :environment do
    Food.delete_all
    csv_text = File.read("#{Rails.root}/data/FoodKeeper-Data.csv").force_encoding('UTF-8')
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
            where_stored =  "Fridge"
          elsif ChronicDuration.parse(row.to_hash["Freeze Output  [Display ONLY!]"]).present?
            expire = ChronicDuration.parse(row.to_hash["Freeze Output  [Display ONLY!]"])
            where_stored =  "Freezer"
          elsif ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"]).present?
            expire = ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"])
            where_stored =  "Fridge"
          else
            expire = ChronicDuration.parse(row.to_hash["Pantry After Opening Output [Display ONLY!]"])
            where_stored =  "Pantry"
          end
        rescue
          expire = ChronicDuration.parse(row.to_hash["Refrigerate After Opening Output  [Display ONLY!]"])
          where_stored =  "Fridge"
        end

        begin
           expire /= 86400
        rescue
          expire = 9001
        end
        puts "#{row.to_hash["Name"]}  #{row.to_hash["Name_subtitle"]} - #{type} - #{expire}"
        begin
          Food.create!(
            food_type: type,
            name: "#{row.to_hash["Name"]} #{row.to_hash["Name_subtitle"]}",
            time_to_expire_in_days: expire,
            where_stored: where_stored
          )
        rescue
          # Do nothing
        end
      end
    end
  end

  task recipes: :environment do
    Food.all.each do |food|
      response = HTTParty.get("http://food2fork.com/api/search?key=6605b2b5c513dc8105d663929596b0ae&q=#{food.name.split.first.encode('UTF-8', :invalid => :replace)}")
      data = response.parsed_response
      if data.present?
        JSON.parse(data)["recipes"].each do |r|
          if Recipe.where(:name => r.to_hash["title"]).empty?
            recipe = Recipe.new(name: r.to_hash["title"], url: r.to_hash["source_url"])
            recipe.foods << Food.search(r.to_hash["title"])
            recipe.save
            puts r.to_hash["title"] + " created"
          else
            puts r.to_hash["title"] + " exists"
          end
        end
      end
    end
  end

end
