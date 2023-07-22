Rails.application.routes.draw do
  get 'likes/create'
  get 'comments/new'
  get 'comments/create'
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end