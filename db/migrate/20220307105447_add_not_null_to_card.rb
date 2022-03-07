class AddNotNullToCard < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cards, :card_set_id, false
  end
end
