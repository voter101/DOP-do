class @App
  constructor: ->
    useCase = new TasksList()
    gui = new Gui()
    tasksBackend = new TasksListBackend()
    glue = new Glue(useCase, gui, tasksBackend)

    useCase.start()