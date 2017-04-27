class CreateNewsletters < ActiveRecord::Migration[5.0]
  def change
    create_table :newsletters do |t|

      t.timestamps
    end
  end
end
