Todo::Application.routes.draw do
  resources :tasks do
    resource :completion, only: [:create, :destroy]
    resource :reassignment, only: [:create]
  end

  resources :lists, only: [] do
    resource :reassignment, only: [:create]
  end

  root to: 'tasks#index'
end
