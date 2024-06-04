Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :children, only: %i[new create]
  resources :contracts, only: %i[new create edit update]
  resources :payslips, only: %i[index show]
  resources :events, only: %i[index show new create]
  resources :user_contracts
  resources :child_contracts


end
