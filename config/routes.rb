Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :children, only: %i[index create update]
  resources :contracts, only: %i[new create index show edit update] do
    resources :payslips, only: %i[create]
    get 'month_events', to: 'events#month_events', as: 'month_events'
    post 'payslip_creation_create', to: 'events#payslip_creation_create', as: 'payslip_creation_create'
    # resources :events, only: [:index, :create], module: :contracts # cette ligne permettrait de gérer nativement les deux du dessus, en mettant un controleur event dans un dossier du contrat
  end
  resources :payslips, only: %i[show]
  post 'payslip/:id/save_pajeemploi_date', to: 'payslips#save_pajeemploi_date', as: 'save_pajeemploi_date'
  post 'payslip/:id/save_bank_date', to: 'payslips#save_bank_date', as: 'save_bank_date'

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
