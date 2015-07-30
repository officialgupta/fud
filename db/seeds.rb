  u = User.first

 20.times do
   i = Item.new(food_id: Food.order("RANDOM()").first.id,
               user: u,
               quantity: rand(10),
               quantity_type: ["kg", "units", "g", "l"].sample,
               when_bought: Date.today - (0..10).to_a.sample.days,
               status: 'in-use')

  if i.save
    puts "Item created!"

  end
 end
