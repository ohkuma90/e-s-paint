Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
  resources :stocks, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :p_informations, only: [:new, :create, :show]
end
