class @TasksListBackend

  getTasks: =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
      @tasksFetched data

  addTask: (content) =>
    request = $.post '/tasks.json',
      'data': {content: content}
    @taskAdded task

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @taskRemoved id

  taskAdded: (task) =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>
