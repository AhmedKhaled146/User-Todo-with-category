Rails.application.routes.draw do

  # Routing For Category
  get "categories", to: "category#index"
  post "categories", to: "category#create" # create new category
  get "categories/:id", to: "category#show" # Get a specific category
  put "categories/:id", to: "category#update" # update a specific category
  delete "categories/:id", to: "category#destroy" # Delete a specific category

  # Routing For Tasks
  get "categories/:category_id/tasks", to: "task#index" # List All Tasks in specific Category(:id)
  post "categories/:category_id/tasks", to: "task#create" # Create a new task under a specific category
  get "categories/:category_id/tasks/:task_id", to: "task#show" # Get a specific task under a specific category
  put "categories/:category_id/tasks/:task_id", to: "task#update" # Update a specific task under a specific category
  delete "categories/:category_id/tasks/:task_id", to: "task#destroy" # Delete a specific task under a specific category



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :category do
    resources :task
  end
  # Defines the root path route ("/")
  root "category#index"
end
