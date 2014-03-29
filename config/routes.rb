DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/tasks/pick', to: 'tasks#pick'
  put '/tasks/done', to: 'tasks#markPickedAsDone'
  get '/tasks/:id', to: 'tasks#showItem'

  get '/tasks/getPicked', to: 'tasks#getPicked'
  get '/tasks', to: 'tasks#show'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
