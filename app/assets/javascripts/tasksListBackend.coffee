class @TasksListBackend

  constructor: ->
    @tasks = []

  getTasks: =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
      @tasks = data
      @tasksFetched @tasks

  addTask: (content) =>
    request = $.post '/tasks.json',
      'data': {content: content}
    @tasks.add(task);
    @taskAdded task

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @taskRemoved id

  taskAdded: (task) =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>
