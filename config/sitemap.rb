# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "http://votre.restaurant"
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


# restaurants area
Restaurant.all.each do |restaurant|
  SitemapGenerator::Sitemap.default_host = "http://#{restaurant.slug}.votre.restaurant"
  SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{restaurant.slug}"
  SitemapGenerator::Sitemap.create do
    add root_path, priority: 0.9
  end
end
