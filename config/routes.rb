Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :children, only: %i[new create index show edit update]
  resources :contracts, only: %i[new create index show edit update]
  resources :payslips, only: %i[index show]
  resources :events, only: %i[show new create]
  resources :user_contracts
  resources :child_contracts

  get '/welcome', to: 'events#index'
end
