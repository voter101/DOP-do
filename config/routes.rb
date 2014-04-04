DOPDo::Application.routes.draw do
  devise_for :users

  root 'application#index'

  get '/tasks/pick', to: 'task_picker#pick'
  put '/tasks/picked/done', to: 'task_picker#mark_picked_done'
  get '/tasks/picked', to: 'task_picker#get_picked'

  get '/tasks/:id', to: 'tasks#get'
  get '/tasks', to: 'tasks#get_all'
  delete '/tasks/:id', to: 'tasks#destroy'
  post '/tasks', to: 'tasks#create'


end
