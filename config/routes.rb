Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  root to: "pages#home"
  resources :users, only: %i[index show] do
    resource :profile, except: %i[destroy show]
    resources :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
  end
  resources :posts, except: [:show, :edit, :update]
  resources :comments, except: [:show, :edit, :update, :index]
  resources :likes, only: [:create, :destroy]
end
