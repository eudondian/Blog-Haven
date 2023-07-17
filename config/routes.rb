Rails.application.routes.draw do
  # get 'posts/index'
  get 'posts/:id', to: 'posts#show', as: :post
  # get 'posts/show'
  # get 'users/index'
  get 'users/:id', to: 'users#show', as: :user
  # get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
