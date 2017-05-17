Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :users, :only => [:show]

  unauthenticated :user do
    root :to => 'scales#create'
  end

  authenticated :user do
    root :to => 'users#current_user_home', :as => 'authenticated_root'
  end

  resources :scales do
    resources :notes
  end

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
