Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index]x
  end

  resources :posts, only [:show]
end