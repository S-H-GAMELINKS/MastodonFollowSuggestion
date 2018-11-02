Rails.application.routes.draw do

  get 'web/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :api, format: 'json' do
    resources :sessions
  end
end
