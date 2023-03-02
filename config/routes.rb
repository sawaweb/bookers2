Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about'
  resources :post_images, only: [:new, :index, :show]
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :index, :show, :edit, :create, :update]
  patch 'books/:id' => 'books#update', as: 'update_book'
  patch 'users/:id' => 'users#update', as: 'update_user'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
