class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, type: :string, foreign_key: true # creates the FK relationships with card_id (which is type string)
      t.timestamps
    end
  end
end
