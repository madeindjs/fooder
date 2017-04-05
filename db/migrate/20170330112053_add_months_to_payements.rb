class AddMonthsToPayements < ActiveRecord::Migration[5.0]
  def change
    add_column :payements, :months, :integer
  end
end
