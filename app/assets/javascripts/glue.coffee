class @Glue
  constructor: (@useCase, @gui, @tasksBackend) ->
    After(@useCase, "start", () => @gui.showTasksUI())
    After(@useCase, "start", () => @tasksBackend.fetchTasks())

    After(@useCase, "tasksSetted", (tasks) => @gui.setTasks(tasks))
    After(@useCase, "removedTask", (id) => @gui.removeTask(id))
    After(@useCase, "pickedTaskSet", (task) => @gui.setPickedTask(task))
    After(@useCase, "markedPickedDone", () => @gui.setTaskPicker())

    After(@tasksBackend, "tasksFetched", (tasks) => @useCase.setTasks(tasks))
    After(@tasksBackend, 'taskAdded', () => @tasksBackend.fetchTasks())
    After(@tasksBackend, 'taskRemoved', (id) => @useCase.removeTask(id))
    After(@tasksBackend, 'fetchedPickedTask', (task) => @useCase.setPickedTask(task))
    After(@tasksBackend, 'noPickedTasks', () => @gui.setTaskPicker())
    After(@tasksBackend, 'markedPickedDone', () => @useCase.markPickedDone())
    After(@tasksBackend, 'taskPicked', (task) => @useCase.setPickedTask(task))

    After(@gui, "showTasksUI", () => @tasksBackend.getPickedTask())
    After(@gui, "taskSubmitted", (content) => @tasksBackend.addTask(content))
    After(@gui, "removeTaskClicked", (id) => @tasksBackend.removeTask(id))
    After(@gui, "taskDoneClicked", () => @tasksBackend.markPickedTaskDone())
    After(@gui, "pickTaskClicked", () => @tasksBackend.pickTask())

    LogAll(@useCase)
    LogAll(@gui)
    LogAll(@tasksBackend)
    LogAll(@tasksOrdering)