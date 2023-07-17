Rails.application.routes.draw do
    user_posts = get 'posts/:id', to: 'posts#show', as: :posts
    user_post = get 'posts/:id', to: 'posts#show', as: :post
    get 'users/:id', to: 'users#show', as: :users
    get 'user/:id', to: 'users#show', as: :user
  end
