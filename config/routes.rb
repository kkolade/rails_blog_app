Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] 
  end
end

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
