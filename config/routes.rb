Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
  resources :stocks, only: [:index, :new, :create, :edit, :update]
  resources :p_informations, only: [:new, :create, :show]
end
