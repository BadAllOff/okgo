class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender, default: 'Other'
      t.text :credo, default: 'Vita verde.'
      t.references :user, foreign_key: true, index:true, unique: true

      t.timestamps
    end
  end
end
