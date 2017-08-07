# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "http://fooder.pro"
SitemapGenerator::Sitemap.create do

  add signout_path
  add signin_path
  add signup_path

  add users_path
  User.all.each do |user|
    add user_path(user)
  end

  add new_password_reset_path

  add contact_path
  add cost_path, priority: 0.8
  add home_path, priority: 0.9

end


Restaurant.all.each do |restaurant|
  SitemapGenerator::Sitemap.default_host = "http://#{restaurant.slug}.fooder.pro"
  SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{restaurant.slug}"
  SitemapGenerator::Sitemap.create do
    # restaurants area

    add root_path, priority: 0.9

    add dishes_path, priority: 0.9
    restaurant.dishes.all.each do |dish|
      add dish_path(dish), lastmod: dish.updated_at
    end

    add posts_path, priority: 0.8
    restaurant.posts.all.each do |post|
      add post_path(post), lastmod: post.updated_at
    end

    add menus_path, priority: 0.9
    restaurant.menus.all.each do |menu|
      add menu_path(menu), lastmod: menu.updated_at
    end

    add contact_path, changefreq: 'monthly', priority: 0.8
  end
end
