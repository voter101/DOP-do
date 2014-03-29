DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/task/pick', to: 'tasks#pick'
  put '/task/done', to: 'tasks#markPickedAsDone'
  get '/task/:id', to: 'tasks#showItem'

  get '/tasks/getPicked', to: 'tasks#getPicked'
  get '/tasks', to: 'tasks#show'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
