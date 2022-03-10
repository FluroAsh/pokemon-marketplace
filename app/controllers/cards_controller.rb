class CardsController < ApplicationController
    before_action :set_card, only: [:show]


    # as all values are preset we don't need any methods for Create, Update or Destroy (only read)
    def index
        @pagy, @cards = pagy(Card.text_search(params[:query]))

    end

    def show; end

    def search

    end

    private
        def card_params; end

        def set_card
            @card = Card.find(params[:id])
        end
end