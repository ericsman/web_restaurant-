Rails.application.routes.draw do

 root to:'home#index'

 get '/profil', to: 'users#edit', as: :profil
 patch '/profil', to: 'users#update'
  resources :sessions, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end
end
