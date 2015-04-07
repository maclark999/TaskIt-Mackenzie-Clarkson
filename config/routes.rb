Rails.application.routes.draw do
  resources :users
  resources :projects do
    resources :tasks
    resources :memberships
  end
  resources :tasks do
    resources :comments
  end 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#homepage'
  get 'faq' => 'faq#index'
  get 'about' => 'about#show'
  get 'terms' => 'pages#terms'
  get '/signup' => 'registrations#new'
  post '/signup' => 'registrations#create'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'


end
