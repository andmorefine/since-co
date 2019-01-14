Rails.application.routes.draw do
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API::Root => '/'

  resource :user

  resources :proverb

  resource :socket
  # トップページ
  root to: "home#index"
end
