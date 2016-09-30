Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }
  root :to => 'scales#index'

  resources :scales do
    resources :notes
  end
end
