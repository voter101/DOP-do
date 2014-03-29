class @TasksListBackend

  constructor: ->
    @tasks = []

  getTasks: =>
    request = $.ajax '/tasks.json',
      dataType: 'json',
      type: 'GET',
    request.success (data) =>
      @tasks = data
      @tasksFetched @tasks

  addTask: (content) =>
    task = {id: 3, content: content}
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
