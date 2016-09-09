Rails.application.routes.draw do
  root :to => 'scales#index'

  resources :scales
end
