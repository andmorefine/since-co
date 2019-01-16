Rails.application.routes.draw do
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API::Root => '/'

  namespace :admin do
    resources :proverb do

      collection do
        get 'preview'
        post 'reset'
      end
    end

  end


  resource :user

  resources :proverb

  resource :socket
  # トップページ
  root to: "home#index"
end
