Rails.application.routes.draw do
  resources :products
  devise_for :users
  resources :rooms
  resources :users, only: :show
  resources :chat_rooms
  resources :messages
  root to: 'home#index'
end
