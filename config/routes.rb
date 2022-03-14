Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  # cards routes
  get "cards", to: "cards#index", as: "cards"
  get "cards/:id", to: "cards#show", as: "card"
  # listing routes
  get "listings", to: "listings#index", as: "listings"
  post "listings", to: "listings#create"
  get "listings/new", to: "listings#new", as: "new_listing"
  get "listings/:id", to: "listings#show", as: "listing"
  put "listings/:id", to: "listings#update"
  patch "listings/:id", to: "listings#update"
  delete "listings/:id", to: "listings#destroy"
  get "listings/:id/edit", to: "listings#edit", as: "edit_listing"
  # profiles routes
  get "profiles/:id", to: "profiles#show", as: "profile"
  get "restricted", to: "pages#restricted"
  # payments routes
  get "payments/success/:id", to: "payments#success", as: "payment_success"
  get "payments/cancel/:id", to: "payments#cancel", as: "payment_cancel"
  post "payments/webhook", to: "payments#webhook"
  post "payments", to: "payments#create_checkout_session", as: "create_checkout_session"
end
