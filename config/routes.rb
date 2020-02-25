Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [] do
    resources :addresses, only: %i[new create edit update destroy]
  end

  resources :events, only: %i[show new create] do
    resources :participants, only: %i[new create destroy]
    resources :selected_restaurants, only: %i[show new create]
    resources :votes, only: %i[new create]
  end

  resources :restaurants, only: %i[index show new create]
end
