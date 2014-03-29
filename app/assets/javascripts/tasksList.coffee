class @TasksList
  constructor: ->
    @tasks = []
    @pickedTask = {}

  start: =>

  setTasks: (tasks) =>
    @tasks = tasks.map((task) ->
      return new Task(task.id, task.content)
    )
    @tasksSetted @tasks

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @removedTask id

  setPickedTask: (task) =>
    @pickedTask = new Task(task[0].id, task[0].content)
    @pickedTaskSet @pickedTask

  fetchTasks: () =>

  tasksSetted: (tasks) =>

  removedTask: (id) =>

  pickedTaskSet: (pickedTask) =>