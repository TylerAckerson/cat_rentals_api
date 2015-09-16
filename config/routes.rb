Rails.application.routes.draw do
  resources :cats, only: [:create, :index, :show, :new, :update, :edit]
  resource :cat_rental_requests
  root 'cats#index'
end
