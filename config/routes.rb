Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    authenticated  do
      root to: 'users#show'
    end

    unauthenticated do
      root to: 'pages#home', as: 'unauthenticated_root'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :addresses, only: %i[index new create edit update destroy]
  end

  resources :events, only: %i[show new create] do
    resources :participants, only: %i[new create]
    resources :selected_restaurants, only: %i[show new create]
    resources :votes, only: %i[new create]
  end
  resources :participants, only: %i[destroy]
  resources :restaurants, only: %i[index show new create]
end
