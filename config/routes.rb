Rails.application.routes.draw do
  resource :unsubscribe, only: [ :show ]

  resource :session
  resources :passwords, param: :token

  resources :products do
    resources :subscribers, only: [ :create ]
  end
  get "/products", to: "products#index"

  get "/products/:id", to: "products#show"

  root "products#index"

  get "signup", to: "passwords#new_registration", as: :new_registration
  post "signup", to: "passwords#create_registration", as: :create_registration

  
end
