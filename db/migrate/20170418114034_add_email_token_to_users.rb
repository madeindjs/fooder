class AddEmailTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    # from https://github.com/jarrett/authlogic_email_token/blob/master/readme.md
    add_column :users, :new_email, :string
    add_column :users, :email_token, :string
    add_column :users, :email_token_updated_at, :datetime
    # Technically the :activated column isn't necessary. This gem doesn't access it
    # directly. Instead, it calls User#activate, which you must implement.
    # (See below.)
    add_column :users, :activated, :boolean, after: :id, null: false, default: false

    # set validity for all old user
    User.all.each { |user|
        user.activated = true
        user.save
    }
  end
end
