Rails.application.routes.draw do
  root "Users#index"

  resources :users, only[:index, :show] do
    resources :posts, only[:index, :show, :new, :create, :destroy] 
  end
end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
