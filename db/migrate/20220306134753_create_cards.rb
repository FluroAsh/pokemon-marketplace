class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :card_set_id, null: false
      t.string :name
      t.string :sprite_name
      t.string :supertype
      t.string :subtypes
      t.string :level
      t.string :ability_name
      t.string :ability_text
      t.string :types
      t.string :weaknesses
      t.string :resistances
      t.string :retreat_cost
      t.string :converted_retreat_cost
      t.string :evolves_from
      t.string :evolves_to
      t.string :flavor_text
      t.string :rules
      t.string :number
      t.string :rarity
      t.string :national_pokedex_number
      t.string :small_image
      t.string :large_image

      t.timestamps
    end
  end
end
