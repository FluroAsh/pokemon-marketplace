class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.references :card, null: false, type: :string, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.integer :condition
      t.string :description
      t.boolean :sold, default: false 

      t.timestamps
    end
  end
end
