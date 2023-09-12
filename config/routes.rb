Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
  resources :users do
    resources :stocks, only: [:index, :new, :create]
  end
end
