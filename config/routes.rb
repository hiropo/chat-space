Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :users, only: [:edit, :update]
  resources :groups, only: [:index, :edit, :update, :new, :create] do 
    resources :messages
  end
end
