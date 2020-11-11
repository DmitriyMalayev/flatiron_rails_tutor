Rails.application.routes.draw do
  resources :appointments
  resources :tutors do  
    resources :appointments, only: [:index, :new]
  end 
  resources :students do 
    resources :tutors, only: [:index]
    resources :appointments, only: [:index, :new]   
  end
  devise_for :users
  root "students#index" 
end