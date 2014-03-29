class @TasksListBackend

  fetchTasks: =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
      @tasksFetched data

  addTask: (content) =>
    request = $.post '/tasks',
      'data': {content: content}
    request.success =>
      @taskAdded()

  removeTask: (id) =>
    request = $.ajax '/tasks/' + id,
      'type': 'DELETE'
    request.success =>
      @taskRemoved id

  taskAdded: =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>
