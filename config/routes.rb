DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/tasks/pick', to: 'tasks#pick'
  put '/tasks/picked/done', to: 'tasks#mark_picked_done'
  get '/tasks/picked', to: 'tasks#get_picked'

  get '/tasks/:id', to: 'tasks#get'
  get '/tasks', to: 'tasks#get_all'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
