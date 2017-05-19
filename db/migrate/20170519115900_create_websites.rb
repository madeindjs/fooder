class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.string :name, null: false, unique: true
      t.string :logo

      t.timestamps
    end

    [
      'Facebook',
      'Twitter',
      'La Fourchette',
      'Linkedin',
      'MySpace',
      'Tripadvisor',
      'Michelin',
      "L'internaute",

    ].each do |name|
      Website.create name: ''
    end
  end
end
