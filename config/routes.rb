Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  get "cards", to: "cards#index", as: "cards"

  get "restricted", to: "pages#restricted"
end
