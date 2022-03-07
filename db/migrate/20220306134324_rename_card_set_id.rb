class RenameCardSetId < ActiveRecord::Migration[6.1]
  def change
    rename_column :card_sets, :id, :card_set_id    
  end
end
