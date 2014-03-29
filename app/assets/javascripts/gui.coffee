class @Gui
  constructor: ->

  createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    element = $(html)

  showTaskList: () =>
    list = @createElementFor("#TasksListTemplate")
    form = @createElementFor("#TaskForm")
    $('.main').append(list)
    $('.main').append(form)
    form.submit(@taskSubmit)
    $('.tasksList').on('click', '.removeTask', @removeTaskClick)

  setTasks: (tasks) =>
    $('.tasksList div').empty()
    tasks.map((task) => @appendTask(task))

  appendTask: (task) =>
    element = @createElementFor('#TaskTemplate', task)
    $('.tasksList').append(element)

  removeTask: (id) =>
    $('.tasksList .task[data-taskId=' + id + ']').slideUp()

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
