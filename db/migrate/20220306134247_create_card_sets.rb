class CreateCardSets < ActiveRecord::Migration[6.1]
  def change
    create_table :card_sets do |t|
      t.string :name
      t.string :series
      t.integer :printed_total
      t.string :symbol
      t.string :logo

      t.timestamps
    end
  end
end
