DOPDo::Application.routes.draw do
  root 'application#index'
  get '/tasks', to: 'tasks#show'
  get '/tasks/:id', to: 'tasks#showItem'
  post '/tasks', to: 'tasks#create'
end
