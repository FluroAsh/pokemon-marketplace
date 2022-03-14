class Card < ApplicationRecord
  belongs_to :card_set
  has_many :listings
  before_save :remove_db_sprite_junk # sanitize data with 'lifecycle hook'

  include PgSearch::Model # imports PgSearch library for PSQL searches
  pg_search_scope :search, against: [:name, :rarity, :card_set_id],
                           associated_against: { card_set: :name }, # allow cross model search against card_set name in card_sets
                           using: { tsearch: { prefix: true } } # allows partial matches (LIKE)

  def self.text_search(query)
    if query.present?
      search(query)
    else
      Card.order("cards.name").all # returns all cards if no match
    end
  end

  def card_prices(id)
    card = Pokemon::Card.find(id)
    return card.cardmarket.prices
    ## // Object Structure //
    #  @average_sell_price
    #  @avg1
    #  @avg30
    #  @avg7
    #  @german_pro_low
    #  @low_price
    #  @low_price_ex_plus
    #  @reverse_holo_avg1
    #  @reverse_holo_avg30
    #  @reverse_holo_avg7
    #  @reverse_holo_low
    #  @reverse_holo_sell
    #  @reverse_holo_trend
    #  @suggested_price
    #  @trend_price
    ## //
  end

  private

  def remove_db_sprite_junk # isolate pokemon name, then remove trailing words if uncaught
    self.sprite_name = self.sprite_name
      .gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| V|Alolan |Brock's/, "").strip
  end
end
