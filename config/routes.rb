Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  get "cards", to: "cards#index", as: "cards"
  get "cards/:id", to: "cards#show", as: "card"
  get "restricted", to: "pages#restricted"
  # listings, listing/:id
  # profile, profile/:id
end
