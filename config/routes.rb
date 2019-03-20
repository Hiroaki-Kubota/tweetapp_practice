# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'home#top'
  get 'about', to: 'home#about'

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'
  get 'signup', to: 'users#new', as: 'new_user'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  get 'users/:id', to: 'users#show', as: 'user'
  patch 'users/:id', to: 'users#update'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  get 'users/:id/likes', to: 'users#likes'

  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create'
  get 'posts/new', to: 'posts#new', as: 'new_post'
  get 'posts/:id/edit', to: 'posts#edit', as: 'edit_post'
  get 'posts/:id', to: 'posts#show', as: 'post'
  patch 'posts/:id', to: 'posts#update'
  put 'posts/:id', to: 'posts#update'
  delete 'posts/:id', to: 'posts#destroy'

  post 'likes/:post_id', to: 'likes#create'
  delete 'likes/:post_id', to: 'likes#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
