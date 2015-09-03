Rails.application.routes.draw do
  resources :drafts do
    get 'edit/:form' => 'drafts#edit', as: 'edit_form'
  end
  get 'welcome/index'
  get 'welcome/collections'

  get 'search' => 'search#index', as: 'search'

  get 'dashboard' => 'pages#dashboard', as: 'dashboard'
  get 'open_drafts' => 'drafts#open_drafts', as: 'open_drafts'
  get 'new_record' => 'pages#new_record', as: 'new_record'

  get "login" => 'users#login'
  get "logout" => 'users#logout'
  get 'urs_callback' => 'oauth_tokens#urs_callback'

  post 'convert' => 'conversions#convert'

  root 'welcome#index'
end
