class Card < ApplicationRecord
  include ApplicationHelper # imports ApplicationHelper for card_prices method
  belongs_to :card_set
  has_many :listings
  
  before_save :remove_db_junk

  include PgSearch::Model # imports PgSearch library for PSQL searches
  pg_search_scope :search, against: [:name, :rarity, :card_set_id, :supertype],
                           associated_against: { card_set: :name }, # allow cross model search against card_set name in card_sets
                           using: { tsearch: { prefix: true } } # allows partial matches (LIKE)

  def self.text_search(query)
    if query.present?
      search(query) # search with query using pgsearch module method
    else
      Card.all # returns all cards if no match, order by card name
    end
  end

  private

  # sanitize data/reformat before saving into the database
  def remove_db_junk # isolate pokemon name, then remove trailing words if uncaught
    self.sprite_name = self.sprite_name.gsub(/Dark |Team Magma's |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| Gl|Detective | V|Alolan |Brock's|Misty's |/i, "").strip
    self.evolves_from = self.evolves_from.to_s if !self.evolves_from.nil?

    if self.national_pokedex_number != nil
      self.national_pokedex_number = ("%03d" % "#{(self.national_pokedex_number.gsub(/"|\[|\]/, "")).to_i}")
    else
      self.national_pokedex_number = self.national_pokedex_number
    end
  end
end
