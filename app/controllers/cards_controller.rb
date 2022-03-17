class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  # DB prepopulated with static data, no create, update or destroy needed
  def index
    @pagy, @cards = pagy(Card.text_search(params[:query]).order("cards.name"))
    # ^^^ breaks the index page, but is faster on profile page...
    # doesn't need to load it on every SHOW CARD
    if @cards.count == 0
      redirect_to root_path, alert: "😥 Couldn't find that card, try again"
    end
  end

  def show
    @cards = Card.includes(:card_sets)
  end

  private

  def set_card
    # set the card, prices & relevant listings required for card overview
    begin
      @card = Card.find(params[:card_id])
      @prices = @card.card_prices(@card.id) # calls API price data using model
    rescue
      redirect_to root_path, alert: "😥 Couldn't find that card, try again"
    end
    # set listings for the listings table (only store in @listings if not sold)
    @listings = Listing.where(card_id: @card.id, sold: false).order(created_at: :desc)
  end
end
