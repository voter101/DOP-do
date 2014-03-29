class @TasksList
  constructor: ->
    @tasks = []

  start: =>

  addTask: (task) =>
    @tasks[task.id] = task
    @taskAdded task

  taskAdded: (task) =>
    return task;

  taskNotAdded: =>
    console.warn "Failed to add task"

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @removedTask id

  removedTask: (id) =>