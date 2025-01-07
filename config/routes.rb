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

end
