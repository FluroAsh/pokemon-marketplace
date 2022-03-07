class Card < ApplicationRecord
    belongs_to :card_set
    has_many :listings

    # sanitize data with 'lifecycle hooks'
    before_save :remove_sprite_junk

    private 
        def remove_sprite_junk # isolate pokemon name, then remove trailing words if uncaught
            self.sprite_name = self.sprite_name
                .gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| V|Alolan |Brock's/, '').strip
        end
end
