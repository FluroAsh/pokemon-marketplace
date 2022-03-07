class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :suburb
      t.integer :postcode

      t.timestamps
    end
  end
end
