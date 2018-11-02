Rails.application.routes.draw do

  get 'web/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/api/sessions/login', to: 'api/sessions#user_session'
end
