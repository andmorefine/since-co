Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :user

  resource :socket
  # トップページ
  root to: "home#index"
end
