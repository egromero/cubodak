Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'landing#index'
  resources :users
  resources :products
  resources :shopping_cart

  get '/auth/signin', to: 'sessions#new'
  post '/auth/signin', to: 'sessions#create'
  get '/auth/siginout', to: 'sessions#destroy_session'
  get '/auth/signup', to: 'users#new'
  post '/auth/signup', to: 'users#create'
  get '/auth/googleLogin', to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#GoogleAuth"
  post "/add_to_bag", to: "shopping_cart#add_to_bag"
  get "/checkout", to: "shopping_cart#checkout"
  get "/get_shopping_cart", to: "shopping_cart#get_shopping_cart"
end
