Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API::Root => '/'

  resource :user

  resource :proverb, only: [:show, :new, :create, :destroy]

  resource :socket
  # トップページ
  root to: "home#index"
end
