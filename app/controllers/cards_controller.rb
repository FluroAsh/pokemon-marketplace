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
    @cards = Card.includes(:users, :card_sets)
    # TO-DO... Get includes working
  end

  private

  def set_card
    begin
      @card = Card.find(params[:id])
      @prices = @card.card_prices(@card.id) # calls API price data using model
    rescue
      redirect_to root_path, alert: "😥 Couldn't find that card, try again"
    end
    # set listings for the listings table
    @listings = Listing.where(card_id: @card.id, sold: false).order(created_at: :desc)
  end
end
