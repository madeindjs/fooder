class AddParamsStatusTransactionIdPurchasedAtToPayements < ActiveRecord::Migration[5.0]
  def change
    add_column :payements, :notification_params, :text
    add_column :payements, :purchased_at, :datetime
  end
end
