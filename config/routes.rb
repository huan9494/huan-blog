Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'blogs#index'
  
  namespace :admin do
    root 'blogs#index'
    resources :blogs do
      collection do
        get :search
      end
    end
    resources :categories
  end
end
