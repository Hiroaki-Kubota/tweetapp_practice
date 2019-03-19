# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#top'
  get 'about' => 'home#about'
  get 'posts' => 'posts#index'
  get 'posts/:id', to: 'posts#show', as: 'post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
