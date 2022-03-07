class AddForeignKeyToCard < ActiveRecord::Migration[6.1]
  def change
    # adds FK constraint to cards table
    # guarantees that a row in the card_sets table exists where the card_set_id matches the cards.card_set_id
    add_foreign_key :cards, :card_sets, primary_key: :card_set_id, index: true, foreign_key: true
  end
end
