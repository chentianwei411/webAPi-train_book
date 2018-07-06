class AuthenticationToken < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authenication_token, :string
    add_index :users, :authenication_token, :unique => true

    User.find_each do |u|
      pust "generate user #{u.id} token"
      u.generate_authentication_token
      u.save!
    end
  end
end
