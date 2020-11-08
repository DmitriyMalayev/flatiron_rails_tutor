Rails.application.routes.draw do
  resources :students
  devise_for :users
  root "students#index" 
end
