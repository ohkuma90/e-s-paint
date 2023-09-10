Rails.application.routes.draw do
  root "stocks#index"
  devise_for :users
end
