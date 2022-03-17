class ListingsController < ApplicationController
  # auth user except before index and show
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]

  def index
    # @listings = Listing.where(card_id: @card.id)
  end

  def show; end

  def new
    @listing = Listing.new # sends params (form) to create action, url params are then cleared (new url 'listings')
  end

  def create
    begin
      @listing = current_user.listings.new(listing_params) # user can't create unless logged in (current_user will return nil)
      if @listing.save
        redirect_to card_path(@listing.card_id), notice: "Listing Successfully created"
      else
        flash[:alert] = "Something went wrong! Try again"
        # pass card_id from form back to the url :id params and try again
        redirect_to new_listing_path(params[:listing][:card_id])
      end
    rescue
      flash[:alert] = "You must sign-in or sign-up to do that"
      # pass card_id from form back to the url :id params and try again
      redirect_to card_path(params[:listing][:card_id])
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authorize_user
    if @listing.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that!"
      redirect_to card_path(@card.id)
    end
  end

  def set_listing
    # set the card data in here so we can use it in the listing model
    @listing = Listing.find(params[:listing_id])
  end

  def listing_params
    params.require(:listing).permit(:price, :condition, :description, :card_id)
  end

  def set_form_vars
    @card = Card.find(params[:card_id]) # works for new but not edit... (what card_id?, url has listing id)
    # edit needs to have card_id passed to it
    @prices = @card.card_prices(@card.id) # loads in prices
    @conditions = Listing.conditions # loads in our enum keys (Poor, good, fair, etc. )
  end
end
