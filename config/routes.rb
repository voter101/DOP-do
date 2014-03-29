DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/tasks/getPicked', to: 'tasks#getPicked'
  get '/task/pick', to: 'tasks#pick'
  put '/task/done', to: 'tasks#markPickedAsDone'

  get '/tasks', to: 'tasks#show'
  get '/task/:id', to: 'tasks#showItem'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
