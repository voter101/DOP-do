class @TasksList
  constructor: ->
    @tasks = []

  start: =>

  setTasks: (tasks) =>
    @tasks = tasks.map((task) ->
      return new Task task.id task.content
    )
    @tasksSetted @tasks

  taskNotAdded: =>
    console.warn "Failed to add task"

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @removedTask id

  tasksSetted: (tasks) =>

  removedTask: (id) =>