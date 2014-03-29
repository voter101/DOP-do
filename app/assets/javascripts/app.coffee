class @App
  constructor: ->
    useCase = new TasksList()
    gui = new Gui()
    tasksBackend = new TasksListBackend()
    tasksOrdering = new TasksListOrdering()
    glue = new Glue(useCase, gui, tasksBackend, tasksOrdering)

    useCase.start()