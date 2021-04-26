Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  get 'post/like/:post_id' => 'likes#save_like', as: :like_post
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
  end
  resources :posts, only: %i[new create destroy]
  resources :comments, only: %i[create]
end
