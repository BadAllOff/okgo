class CreateAuthentication < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
