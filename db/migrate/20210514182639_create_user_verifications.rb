class CreateUserVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.string :token
      t.string :verify_type

      t.timestamps
    end
    add_index :user_verifications, :status
    add_index :user_verifications, :token, unique: true
    add_index :user_verifications, :verify_type
  end
end
