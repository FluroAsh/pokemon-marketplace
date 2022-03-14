class ListingsController < ApplicationController
    before_action :authneticate_user!, except: [:index, :show]

    def index
    end

    def show
    end

    def new
        @listing = Listing.new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    def listings_params
        params.require(:listing).permit(:price, :condition, :description)
    end
end
