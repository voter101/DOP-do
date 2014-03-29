class @Glue
  constructor: (@useCase, @gui, @tasksBackend, @tasksOrdering)->
    After(@useCase, "start", => @gui.showTaskList())
    After(@useCase, "start", => @tasksBackend.getTasks())

    After(@useCase, "addedTask", (task) => @gui.appendTask(task))
    After(@useCase, "removedTask", (id) => @gui.removeTask(id))

    After(@tasksBackend, "tasksFetched", (tasks) => @gui.setTasks(tasks))
    After(@tasksBackend, 'taskAdded', (task) => @useCase.addTask(task))
    After(@tasksBackend, 'taskRemoved', (id) => @useCase.removeTask(id))

    After(@gui, "taskSubmitted", (content) => @tasksBackend.addTask(content))
    After(@gui, "removeTaskClicked", (id) => @tasksBackend.removeTask(id))

    LogAll(@useCase)
    LogAll(@gui)
    LogAll(@tasksBackend)
    LogAll(@tasksOrdering)

