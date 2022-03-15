class ListingsController < ApplicationController
  # auth user except before index and show
  #   before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    # @listings = Listing.where(card_id: @card.id)
  end

  #   def show; end

  def new
    @listing = Listing.new # sends params (form) to create action, url params are then cleared (new url 'listings')
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to card_path(@listing.card_id), notice: "Listing Successfully created"
    else
      flash[:alert] = "Something went wrong! Try again"
      # pass card_id from form back to the url :id params and try again
      redirect_to new_listing_path(params[:card][:card_id])
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_listing
    # set the card data in here so we can use it in the listing model
    @listing = Listing.find(params[:id]) # we pass in
  end

  def listing_params
    params.require(:listing).permit(:price, :condition, :description, :card_id)
  end

  def set_form_vars
    @card = Card.find(params[:id])
    @prices = @card.card_prices(@card.id) # loads in prices
    @conditions = Listing.conditions # loads in our enum keys (Poor, good, fair, etc. )
  end
end
