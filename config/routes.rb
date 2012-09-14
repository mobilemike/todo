Todo::Application.routes.draw do
  resources :tasks, only: [:create, :edit, :update] do
    resource :completion, only: [:create, :destroy]
    resource :reassignment, only: [:create]
  end

  resources :lists, only: [:index] do
    resource :reassignment, only: [:create]
  end

  root to: 'lists#index'
end
