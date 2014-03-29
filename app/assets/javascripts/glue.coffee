class @Glue
  constructor: (@useCase, @gui, @tasksBackend)->
    After(@useCase, "start", () => @gui.showTaskList())
    After(@useCase, "start", () => @tasksBackend.fetchTasks())

    After(@useCase, "tasksSetted", (tasks) => @gui.setTasks(tasks))
    After(@useCase, "removedTask", (id) => @gui.removeTask(id))

    After(@tasksBackend, "tasksFetched", (tasks) => @useCase.setTasks(tasks))
    After(@tasksBackend, 'taskAdded', () => @tasksBackend.fetchTasks())
    After(@tasksBackend, 'taskRemoved', (id) => @useCase.removeTask(id))

    After(@gui, "taskSubmitted", (content) => @tasksBackend.addTask(content))
    After(@gui, "removeTaskClicked", (id) => @tasksBackend.removeTask(id))

    LogAll(@useCase)
    LogAll(@gui)
    LogAll(@tasksBackend)
    LogAll(@tasksOrdering)