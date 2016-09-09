Rails.application.routes.draw do
  root :to => 'scales#index'

  resources :scales do
    resources :notes
  end
end
