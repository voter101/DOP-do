class @Gui
  constructor: ->

  createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    element = $(html)

  showTasksUI: () =>
    tasks = @createElementFor("#Tasks")
    taskPick = @createElementFor("#TaskPick")
    list = @createElementFor("#TasksListTemplate")
    form = @createElementFor("#TaskForm")
    $('.main').append(tasks)
    $('.tasks').append(taskPick)
    $('.tasks').append(list)
    $('.tasks').append(form)
    @bindEvents(form)

  bindEvents: (taskSubmitForm) =>
    taskSubmitForm.submit(@taskSubmit)
    $('.taskForm button').click( -> $('.taskForm').trigger('submit') )
    $('.tasksList').on('click', '.removeTask', @removeTaskClick)
    $('.taskPick').on('click', '.taskDone', @taskDoneClick)
    $('.taskPick').on('click', '.pickTask', @pickTaskClick)

  setTasks: (tasks) =>
    $('.tasksList').empty()
    tasks.map((task) => @appendTask(task))

  appendTask: (task) =>
    element = @createElementFor('#TaskListTemplate', task)
    $('.tasksList').append(element)

  removeTask: (id) =>
    $('.tasksList .task[data-taskId=' + id + ']').slideUp()

  setPickedTask: (task) =>
    element = @createElementFor('#TaskPicked', task)
    $('.taskPick').empty()
    $('.taskPick').append(element)

  setTaskPicker: () =>
    element = @createElementFor('#TaskPicker')
    $('.taskPick').empty()
    $('.taskPick').append(element)

  removeTaskClick: (event) =>
    id = $(event.target).attr('data-taskId')
    @removeTaskClicked id

  taskSubmit: (event) =>
    event.preventDefault()
    contentInput = $(event.target).find('[name=content]')
    content = contentInput.val();
    contentInput.val('');
    if content.length > 3
      @taskSubmitted content

  taskDoneClick: (event) =>
    @taskDoneClicked()

  pickTaskClick: (event) =>
    @pickTaskClicked()

  taskDoneClicked: () =>

  taskSubmitted: (content) =>

  removeTaskClicked: (id) =>
