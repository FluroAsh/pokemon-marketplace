class Card < ApplicationRecord
  belongs_to :card_set
  has_many :listings
  before_save :remove_sprite_junk # sanitize data with 'lifecycle hooks'

  include PgSearch::Model # establish scopes for our searching method
  pg_search_scope :search, against: [:name, :rarity],
                           using: { tsearch: { prefix: true, dictionary: "english" } }, # uses en dictionary to distinguish plurals eg: (character vs characters etc
                           associated_against: { card_set: :name } # also searches against card_set name if user enters for eg: 'team rocket' retrieving cards belonging to 'team rocket'

  def self.text_search(query)
    if query.present?
      search(query)
    else
      Card.order("cards.name").all # returns all cards if no match
    end
  end

  private

  def remove_sprite_junk # isolate pokemon name, then remove trailing words if uncaught
    self.sprite_name = self.sprite_name
      .gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| V|Alolan |Brock's/, "").strip
  end
end
