class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :account_num, limit: 8, null: false
      t.string :password_digest, null: false
      t.money :amount, null: false, :default => 0
      t.string :session_token, null: false

      t.timestamps
    end
    add_index :accounts, :account_num, unique: true
  end
end
