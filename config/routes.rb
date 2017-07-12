Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'blogs#index'
  
  namespace :admin do
    root 'blogs#index'
    resources :blogs
    resources :categories
  end
end
