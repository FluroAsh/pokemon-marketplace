class FavouritesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_favourite, only: [:destroy]

  def create # create new favourite for associated user & card_id with passed in params[:card_id]
    @favourite = current_user.favourites.new(favourite_params)
    if @favourite.save
      redirect_to card_path(@favourite.card.id), notice: "Favourite added! ♥"
    else
      flash[:alert] = @favourite.errors.full_message unless @favourite.save!
      redirect_to card_path(params[:card_id])
    end
  end

  def destroy
    @favourite.destroy
    flash[:notice] = "Successfully un-favourited"
    redirect_to card_path(params[:card_id])
  end

  private

  def set_favourite
    @favourite = Favourite.find_by(user_id: current_user.id, card_id: params[:card_id])
  end

  def favourite_params
    params.permit(:card_id)
  end
end
