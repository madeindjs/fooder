class AddSlugToRestaurants < ActiveRecord::Migration[5.0]
  def up
    add_column :restaurants, :slug, :string
    add_index :restaurants, :slug, unique: true

    say_with_time 'generating restaurants slugs' do
      Restaurant.find_each(&:save)
    end
  end

  def down
    remove_column :restaurants, :slug, :string
  end
end
