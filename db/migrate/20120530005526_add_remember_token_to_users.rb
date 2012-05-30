class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column 	:users, :remember_token, :string
  	add_index 	:users, :remember_token  # because we expect to retrieve users by remember token
  end
end
