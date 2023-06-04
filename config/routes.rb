Rails.application.routes.draw do
  resources :users, only: [:index] do
    
    resources :follows, only: [:destroy] do
      post '', on: :member, to: 'follows#create'
    end

    resources :sleeps, only: [:create, :index] do
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
