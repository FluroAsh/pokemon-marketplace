class ListingsController < ApplicationController
  # verify user except for show action
  # auth user for edit, update & destroy, prevent un-authorised users from tampering with others users listings
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_card, only: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :verify_user, except: [:show] # verify user signed in except on index & show action
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
        # must use params and not set_form vars private method beacuse card_id is nested in listing params
        # when the user submits the form with the associated card_id encased in our hidden_field
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

  def authorize_user # if there is no current user session or there's no seller match redirect to root path
    if current_user.nil? || @listing.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that!"
      redirect_to root_path
    end
  end

  def set_listing
    # queries db to find listing based on url params (listing_id)
    # assigns this to @listing to variable for use in show, edit, update and destroy controller actions
    @listing = Listing.find(params[:listing_id])
  end

  def set_card
    # queries db to find a card match for the listing that a user is trying to view through the show action
    # uses the listing association to find the correct card_id and then retrieve the relevant card information
    @card = Card.find(@listing.card.id)
    # uses the above to retrieve pricing information from the Pokemon TCG API in our application_helper method
    # specifically utilising the newly acquired @card variable and the associated card ID
    @prices = @card.card_prices(@card.id)
  end

  def listing_params # card_id passed in with hidden field so we can reset form vars
    params.require(:listing).permit(:price, :condition, :description, :card_id)
  end

  def set_form_vars
    # sets the form variables for new & edit controller actions
    @card = Card.find(params[:card_id]) # search db for our card used to populate card attributes within the listings view
    # !>>(last minute could NOT figure out why includes does not work for card_set given it has an association)
    @prices = @card.card_prices(@card.id) # loads in prices (dependent on our @card id)
    @conditions = Listing.conditions # loads in our enum keys (Poor, good, fair, etc. ) from the listings model
  end
end
