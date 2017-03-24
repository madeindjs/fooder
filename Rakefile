# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks


namespace "pictures"  do
  desc "regenerate all pictures"
  task :regen => :environment do
    

    [Dish, Menu, Post, Restaurant].each do |model|

      model.all.select{|r| !r.picture.file.nil? }.each do |entity|
         begin
          entity.picture.recreate_versions!
          puts "#{entity.id} - #{entity} resized!"
        rescue => e
          puts  "ERROR: #{entity.id} - #{entity} -> #{e.to_s}"
        end
      end

    end





  end
end