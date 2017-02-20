10.times do

    u = User.create email: Faker::Internet.email, 
        password: "20462046",
        password_confirmation: "20462046",
        firstname: Faker::Name.first_name, 
        lastname: Faker::Name.last_name


    r = Restaurant.create name: Faker::Food.ingredient,
        user_id: u.id,
        address: Faker::Address.street_address,
        zip_code: Faker::Address.zip_code, 
        city: Faker::Address.city


    10.times do
        Dish.create name: Faker::Food.ingredient,
            description: Faker::Food.ingredient + " & " + Faker::Food.ingredient + " & "  + Faker::Food.ingredient,
            category_id: u.categories.order("RANDOM()").first.id,
            user_id: u.id,
            restaurant_id: r.id,
            price: rand(11.2...25.9).ceil(2)
    end

end
