Rails.application.routes.draw do
  root to: 'projects#index'
  devise_for :users
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :projects do
    resources :tasks
  end

  resources :tags do
    get 'projecs', to: 'projects#search'
  end
  
  
end
