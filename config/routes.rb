Rails.application.routes.draw do
    user_posts = get 'posts/:id', to: 'posts#show', as: :posts
    user_post = get 'post/:id', to: 'post#show', as: :post
    get 'users/:id', to: 'users#show', as: :users
    get 'user/:id', to: 'user#show', as: :user
    # get 'user', to: 'users#index', as: :user
  end
