class AddPremiumUntilToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :premium_until, :datetime
  end
end
