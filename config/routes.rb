Rails.application.routes.draw do
  devise_for :users
  root :to => 'scales#index'

  resources :scales do
    resources :notes
  end
end
