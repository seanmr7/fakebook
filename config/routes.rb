Rails.application.routes.draw do
  resources :comments
  resources :posts
  devise_for :users
  root to: "pages#home"
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
  end
  resources :posts, except: [:show, :edit, :update]
end
