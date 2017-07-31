Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'blogs#index'

  resources :blogs, only: [:index, :show]
  resources :comments, only: [:create]
  post 'blogusers/create'
  get 'blogs/:id/author', to: 'blogs#author'
  namespace :admin do
    root 'blogs#default_admin_page'
    get 'blogs/default_admin_page'
    patch 'blogs/:id/confirm', to: 'blogs#confirm'
    # post 'blogs/confirm', to: 'blogs#confirm'
    resources :blogs do
      collection do
        get :search
        post :confirm
      end
    end
    resources :categories
  end
end
