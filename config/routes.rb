Rails.application.routes.draw do
  resources :rooms
  root to: 'home#index'
end
