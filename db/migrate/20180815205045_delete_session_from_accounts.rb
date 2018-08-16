class DeleteSessionFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :session_token
  end
end
