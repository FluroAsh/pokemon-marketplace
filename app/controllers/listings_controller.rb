class ListingsController < ApplicationController
  # auth user except before index and show
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_card, only: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :verify_user, except: [:index, :show] # verify user signed in except on index & show action
  before_action :set_form_vars, only: [:new, :edit]

  def index; end

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
      # user needs to login, reroute to the card show path
      redirect_to card_path(params[:listing][:card_id])
    end
  end

  def edit; end

  def update
    begin
      @listing.update(listing_params) # user can't create unless logged in (current_user will return nil)
      if @listing.save
        redirect_to card_path(@listing.card_id), notice: "Listing Successfully updated"
      else
        flash[:alert] = "Something went wrong! Try again"
        # pass card_id from form back to the url :id params and try again
        redirect_to edit_listing_path(listing_id: @listing.id, card_id: params[:listing][:card_id])
      end
    rescue
      flash[:alert] = "You must sign-in or sign-up to do that"
      # user needs to login, reroute to the card show path
      redirect_to card_path(params[:listing][:card_id])
    end
  end

  def destroy
    @listing.destroy
    redirect_to cards_path
  end

  private

  def verify_user # verify there is an active user before accessing sensitive controller actions
    if current_user.nil?
      flash[:alert] = "You don't have permission to do that!"
      redirect_to root_path
    end
  end

  def authorize_user # if there is no current user session or there's no user match redirect to root path
    if current_user.nil? || @listing.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that!"
      redirect_to root_path
    end
  end

  def set_listing
    # set the card data in here so we can use it in the listing model
    @listing = Listing.find(params[:listing_id])
  end

  def set_card # gets our card & prices data
    @card = Card.find(@listing.card.id)
    @prices = @card.card_prices(@card.id)
  end

  def listing_params
    params.require(:listing).permit(:price, :condition, :description, :card_id)
  end

  def set_form_vars
    @card = Card.find(params[:card_id]) # 
    @prices = @card.card_prices(@card.id) # loads in prices (dependent on our @card id)
    @conditions = Listing.conditions # loads in our enum keys (Poor, good, fair, etc. )
  end
end
