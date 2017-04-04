class CreatePayements < ActiveRecord::Migration[5.0]
  def change
    create_table :payements do |t|
      t.integer :user_id
      t.string :transaction_id
      t.integer :status

      t.timestamps
    end
  end
end
