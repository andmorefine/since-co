# frozen_string_literal: true

Rails.application.routes.draw do
  mount_roboto
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API::Root => '/'

  namespace :admin do
    resources :home do
      collection do
        get 'fetch'
      end
    end
    resources :proverb do
      collection do
        get 'preview', 'alphabetal'
      end
      member do
        get :fetch
        get :versions
      end
    end
  end

  resources :alphabetal

  resources :proverb do
    collection do
      get 'search'
    end
  end

  resources :item do
    collection do
      post 'save_s3_images'
    end
  end

  resources :contact, only: %i[new create] do
    collection do
      get 'thanks'
    end
  end

  resource :socket
  # トップページ
  root to: 'home#index'
end
