Rails.application.routes.draw do
  resources :appointments
  resources :tutors
  resources :students
  devise_for :users
  root "students#index" 
end