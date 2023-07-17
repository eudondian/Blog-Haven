Rails.application.routes.draw do
    get 'posts/:id', to: 'posts#show', as: :post
    get 'users/:id', to: 'users#show', as: :user
  end
