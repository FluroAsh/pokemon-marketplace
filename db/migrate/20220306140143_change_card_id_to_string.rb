class ChangeCardIdToString < ActiveRecord::Migration[6.1]
  def change
    change_column :cards, :id, :string
  end
end
