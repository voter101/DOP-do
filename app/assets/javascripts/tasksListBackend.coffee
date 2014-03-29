class @TasksListBackend

  fetchTasks: =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
      @tasksFetched data

  addTask: (content) =>
    request = $.post '/tasks.json',
      'data': {content: content}
    request.done => @taskAdded

  removeTask: (id) =>
    @tasks.remove( (task) -> parseInt(task.id) == parseInt(id) )
    @taskRemoved id

  taskAdded: =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>
