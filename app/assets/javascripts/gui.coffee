class @Gui
  constructor: ->

  createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    element = $(html)

  showTaskList: () =>
    tasks = @createElementFor("#Tasks")
    list = @createElementFor("#TasksListTemplate")
    form = @createElementFor("#TaskForm")
    $('.main').append(tasks)
    $('.tasks').append(list)
    $('.tasks').append(form)
    form.submit(@taskSubmit)
    $('.taskForm button').click( -> $('.taskForm').trigger('submit') )
    $('.tasksList').on('click', '.removeTask', @removeTaskClick)

  setTasks: (tasks) =>
    $('.tasksList').empty()
    tasks.map((task) => @appendTask(task))

  removeTask: (id) =>
    $('.tasksList .task[data-taskId=' + id + ']').slideDown()

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

  taskSubmitted: (content) =>

  removeTaskClicked: (id) =>
