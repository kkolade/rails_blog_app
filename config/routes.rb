Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # HTML routes for authenticated users
  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in')

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: [:create]
    end
  end

  # API routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :create] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
