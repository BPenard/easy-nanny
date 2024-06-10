Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :children, only: %i[new create index show edit update]
  resources :contracts, only: %i[new create index show edit update] do
    resources :payslips, only: %i[show create]
  end
  resources :payslips, only: %i[index]
  resources :events, only: %i[index show new create]

  resources :user_contracts
  resources :child_contracts
  namespace :contract_intake do
    resources :nanny_contracts, only: %i[new create]
    resources :information_contracts, only: %i[new create]
    resources :recap_contracts, only: %i[show]
  end

  get '/welcome', to: 'events#index'
end
