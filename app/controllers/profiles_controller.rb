class ProfilesController < ApplicationController
  before_action :set_profile, :set_cards, only: [:show]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params) # save validation handled by devise
  end

  def show; end

  private

  def set_cards # sets cards for the favourites section
    if @user.favourites.present? # if user has any favourites present
      ids = []
      @user.favourites.each do |c|
        ids << c.card_id
      end
      # query database for cards that belongs to our users 
      # favourites card_ids and assign to a var for iteration in the view
      @cards = Card.where(id: ids) 
    end
  end

  def set_profile
    if Profile.where(id: params[:id]).present? # error handling to see if profile params[:id] exists
      # queries database to find match for params[:id] and the profile_id stored in db
      # no associated data required
      @profile = Profile.find(params[:id])
      @user = User.find(@profile.user_id) # finds the user_id associated with the profile
    else
      flash[:alert] = "That user does not exist"
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :state, :suburb, :postcode)
  end
end
