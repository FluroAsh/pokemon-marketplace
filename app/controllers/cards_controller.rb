class CardsController < ApplicationController
  before_action :set_card, only: [:show]

  def index
    # pagy & card variable receive results of card model PgSearch method query
    # (params received from respective search form, and orederd by cards.name)
    @pagy, @cards = pagy(Card.text_search(params[:query]).order("cards.name"))
    if @cards.count == 0
      redirect_to root_path, alert: "😥 Couldn't find that card, try again"
    end
  end

  def show
    # when a request is made for both all cards and card_sets to be made available to the view/controller
    @cards = Card.includes(:card_sets)
  end

  private

  def set_card # set the card, prices & relevant listings required for card overview
    begin
      @card = Card.find(params[:card_id])
      @prices = @card.card_prices(@card.id) # calls API price data using model
    rescue
      redirect_to root_path, alert: "😥 Couldn't find that card, try again"
    end
    # set listings for the listings table (only store in @listings if not sold)
    # sort by created at, most recent populates to the top of the table
    @listings = Listing.where(card_id: @card.id, sold: false).order(created_at: :desc)
  end
end
