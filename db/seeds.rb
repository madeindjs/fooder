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

end
