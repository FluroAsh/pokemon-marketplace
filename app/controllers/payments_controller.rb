class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook] # Allows stripe to post to our webhook server (localhost:3000)
  before_action :set_listing, only: [:success, :cancel] # So we can pass attributes to the view (title, description etc.)

  def success
    @order = Order.find_by(listing_id: @listing.id)
    redirect_to payment_success_path(params[:id])
  end

  def cancel
    @order = Order.find_by(listing_id: @listing.id)
    redirect_to card_path(@listing.card.id)
    flash[:alert] = "Order for #{@listing.card.name} was cancelled 👋"
  end

  def webhook # creates order and posts to stripe
    begin
      payload = request.raw_post # Everything that comes in from our request//similar to params
      header = request.headers["HTTP_STRIPE_SIGNATURE"]
      secret = Rails.application.credentials.dig(:stripe, :webhook_signature)
      event = Stripe::Webhook.construct_event(payload, header, secret)
    rescue Stripe::SignatureVerificationError => e
      render json: { error: "Unauthorised" }, status: 403
      return
    rescue JSON::ParseError => e
      render json: { error: "Bad request" }, status: 422
      return
    end
    # payment_id = params[:data][:object][:payment_intent]
    payment_id = event.data.object.payment_intent
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    # find the listing in the db - update sold to true
    @listing = Listing.find(listing_id)
    @listing.update(sold: true)
    # CREATE ORDER/PURCHASE & TRACK EXTRA INFO
    Order.create(listing_id: listing_id, seller_id: @listing.user_id, buyer_id: payment.metadata.user_id, payment_id: payment_id, receipt_url: payment.charges.data[0].receipt_url)
  end

  def create_checkout_session # creates thes session
    @listing = Listing.find(params[:id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: current_user && current_user.email, # current_user.email set to nil if no current_user
      line_items: [{
        name: @listing.card.name,
        description: @listing.description,
        amount: @listing.price,
        images: [@listing.card.large_image],
        currency: "aud",
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: { # Used to track who bought which card
          user_id: current_user && current_user.id, # same as above, .id set to nil if no user
          listing_id: @listing.id,
        },
      },
      success_url: "#{root_url}/payments/success/#{@listing.id}",
      cancel_url: "#{root_url}/payments/cancel/#{@listing.id}",
    )
    @session_id = session.id # Saves the session.id into an instance variable so we can locate the information
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
