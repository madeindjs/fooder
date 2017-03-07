class AddSlugToOtherModels < ActiveRecord::Migration[5.0]
  def up

    add_column :dishes, :slug, :string
    add_index :dishes, :slug, unique: true
    say_with_time 'generating dishes slugs' do
      Dish.find_each(&:save)
    end 

    add_column :menus, :slug, :string
    add_index :menus, :slug, unique: true
    say_with_time 'generating menus slugs' do
      Menu.find_each(&:save)
    end 

    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
    say_with_time 'generating posts slugs' do
       Post.find_each(&:save)
    end

    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    say_with_time 'generating users slugs' do
      User.find_each(&:save)
    end

  end

  def down
    remove_column :dishes, :slug, :string
    remove_column :menus, :slug, :string
    remove_column :posts, :slug, :string
    remove_column :users, :slug, :string
  end

end
