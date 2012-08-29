Todo::Application.routes.draw do
  resources :tasks do
    resource :completion, only: [:create, :destroy]
  end

  root to: 'tasks#index'
end
