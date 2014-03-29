DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/tasks/getPicked', to: 'tasks#getPicked'
  get '/tasks/pick', to: 'tasks#pick'
  put '/tasks/done', to: 'tasks#markPickedAsDone'

  get '/tasks', to: 'tasks#show'
  get '/tasks/:id', to: 'tasks#showItem'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
