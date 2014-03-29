class @TasksList
  constructor: ->
    @tasks = []

  start: =>

  setTasks: (tasks) =>
    @tasks = tasks.map((task) ->
      return new Task task.id task.content
    )
    @tasksSetted @tasks

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @removedTask id

  tasksSetted: (tasks) =>

  removedTask: (id) =>