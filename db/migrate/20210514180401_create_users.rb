class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.datetime :email_confirmed_at

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :email_confirmed_at
  end
end
