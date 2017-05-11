class CreateJoinTableMenusDishes < ActiveRecord::Migration[5.0]
  def change
    create_join_table :dishes, :menus do |t|
      # t.index [:dish_id, :menu_id]
      # t.index [:menu_id, :dish_id]
    end
  end
end
