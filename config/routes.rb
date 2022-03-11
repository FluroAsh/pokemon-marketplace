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
  get "profiles/:id", to: "profiles#show", as: "profile" # extension of devise user routes
  get "restricted", to: "pages#restricted"
end
