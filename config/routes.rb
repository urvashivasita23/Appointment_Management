# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  post 'appointment/create', to: 'appointments#create'

  # Only Admin can see Users Index
  resources :users, except: [:index]
  # Patients can only view Doctors' Index and Show Page
  resources :doctors, only: %i[index show]
  # Patients access to web application
  resources :patients, only: %i[new create show] do
    resources :appointments, only: %i[index new create show]
  end

  # Doctors access to web application
  resources :doctors, only: %i[new create show] do
    resources :patients, only: %i[show]
    resources :appointments, only: %i[index show]
  end
  namespace :doctors, only: %i[new create show]  do
    resources :users, only: %i[index show edit update destroy]
    resources :patients, only: %i[show]
    resources :appointments, only: %i[index show]
  end

  # filter Doctors Specialty
  get '/select_specialty', to: 'appointments#select_specialty'
  post '/patients/:patient_id/appointments/new', to: 'appointments#new'

  # Admin privileges
  namespace :admin do
    resources :users, only: %i[index show edit update destroy]
    resources :patients, only: %i[edit update index] do
      match :q, to: 'patients#index', via: :get, on: :collection
    end
    resources :doctors, only: %i[edit update index show]
    resources :appointments, only: %i[edit update destroy index]
  end

  # Doctor privileges
  namespace :doc do
    resources :users, only: %i[index show edit update destroy]
    resources :patients, only: %i[index] do
      match :q, to: 'patients#index', via: :get, on: :collection
    end
    resources :doctors, only: %i[edit update index show]
    resources :appointments, only: %i[edit update index show]
  end

  # namespace :doctors, only: %i[new create show]  do
  #   resources :users, only: %i[index show edit update destroy]
  #   resources :patients, only: %i[show]
  #   resources :appointments, only: %i[index show]
  # end

end
