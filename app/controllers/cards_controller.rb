class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  # DB prepopulated with static data, no create, update or destroy needed
  def index
    @pagy, @cards = pagy(Card.text_search(params[:query]).order("cards.name"))
    # ^^^ breaks the index page, but is faster on profile page...
    # doesn't need to load it on every SHOW CARD
    if @cards.count == 0
      flash[:alert] = "No cards found, please try again"
      redirect_to root_path
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
      @listings = Listing.where(card_id: @card.id).order(created_at: :desc)
    rescue
      retry
    end
  end
end
