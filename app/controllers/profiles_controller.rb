class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]

  def create
    @profile = Profile.new(profile_params) # save validation handled by devise
  end

  def show; end

  private

  def set_profile
    if Profile.where(id: params[:id]).present? # error handling to see if associated user & profile exists
      @profile = Profile.find(params[:id])
      @user = User.find(params[:id]) # finds the user_id associated with the profile
    else
      flash[:alert] = "That user does not exist"
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :state, :suburb, :postcode)
  end
end
