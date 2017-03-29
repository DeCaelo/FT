Rails.application.routes.draw do
  resources :communes, only: [:index, :create, :show, :update]
end
