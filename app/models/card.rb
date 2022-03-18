class Card < ApplicationRecord
  include ApplicationHelper # imports ApplicationHelper for card_prices method
  belongs_to :card_set
  has_many :listings
  before_save :remove_db_sprite_junk # sanitize data with 'lifecycle hook'
  # additional hooks will go here

  include PgSearch::Model # imports PgSearch library for PSQL searches
  pg_search_scope :search, against: [:name, :rarity, :card_set_id, :supertype],
                           associated_against: { card_set: :name }, # allow cross model search against card_set name in card_sets
                           using: { tsearch: { prefix: true } } # allows partial matches (LIKE)

  def self.text_search(query)
    if query.present?
      search(query) # search with query using pgsearch module method
    else
      Card.order("cards.name").all # returns all cards if no match
    end
  end

  private

  # sanitize data here (move methods from seed_helper)
  def remove_db_sprite_junk # isolate pokemon name, then remove trailing words if uncaught
    self.sprite_name = self.sprite_name.gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| Gl|Detective | V|Alolan |Brock's|Misty's |/i, "").strip
  end
end
