class AddProcoreLoginToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :procore_login, :string
    add_column :users, :procore_password, :string
  end
end
