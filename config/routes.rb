Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  # cards
  get "cards", to: "cards#index", as: "cards"
  get "cards/:card_id", to: "cards#show", as: "card"
  # listings
  post "listings", to: "listings#create", as: "create_listing"
  get "listings/new/:card_id", to: "listings#new", as: "new_listing"
  get "listings/:listing_id", to: "listings#show", as: "listing"
  put "listings/:listing_id", to: "listings#update"
  patch "listings/:listing_id", to: "listings#update"
  delete "listings/:listing_id", to: "listings#destroy"
  get "listings/edit/:listing_id/:card_id", to: "listings#edit", as: "edit_listing" # requires listing_id and card_id incase of fail
  # profiles
  get "profiles/:id", to: "profiles#show", as: "profile"
  # favourites
  post "favourites", to: "favourites#create", as: "create_favourite"
  delete "favourites/:card_id", to: "favourites#destroy"
  # payments (stripe etc)
  get "payments/success/:id", to: "payments#success", as: "payment_success"
  get "payments/cancel/:id", to: "payments#cancel", as: "payment_cancel"
  post "payments/webhook", to: "payments#webhook"
  post "payments", to: "payments#create_checkout_session", as: "create_checkout_session"
end
