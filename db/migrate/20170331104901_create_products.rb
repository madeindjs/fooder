class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :months
      t.float :price
      t.boolean :activate, default: true
      t.timestamps
    end

    Product.create name: '1 mois', months: 1,  price: 9.99
    Product.create name: '3 mois', months: 3,  price: 26.99
    Product.create name: '6 mois', months: 6,  price: 55.99
    Product.create name: '1 an',   months: 12, price: 99.99
    Product.create name: '2 ans',  months: 24, price: 199.99
    Product.create name: 'A vie',  months: 0,  price: 359.99
  end
end
