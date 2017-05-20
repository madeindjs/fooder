class CreateLinkTypes < ActiveRecord::Migration[5.0]
  def change
    # create Model table
    create_table :link_types do |t|
      t.string :name, null: false, unique: true
      t.string :logo

      t.timestamps
    end

    # create first link types with most famous sites
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
      LinkType.create name: name
    end

    # link has one link type
    add_column :links, :link_type_id, :integer

  end
end
