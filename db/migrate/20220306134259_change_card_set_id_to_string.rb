class ChangeCardSetIdToString < ActiveRecord::Migration[6.1]
  def change
    change_column :card_sets, :id, :string
  end
end
