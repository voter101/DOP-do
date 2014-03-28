DOPDo::Application.routes.draw do
  root 'application#index'
  get '/tasks', to: 'tasks#show'
end
