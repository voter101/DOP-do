class @TasksListBackend
  fetchTasks: () =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
      data.map((task) -> new Task(task.id, task.content))
      @tasksFetched data

  addTask: (content) =>
    request = $.post '/tasks',
      'data': {content: content}
    request.success =>
      @taskAdded()

  removeTask: (id) =>
    request = $.ajax '/tasks/' + id,
      'type': 'DELETE'
    request.success =>
      @taskRemoved id

  getPickedTask: () =>
    request = $.get '/tasks/getPicked',
      dataType: 'json'
    request.success (data) =>
      @fetchedPickedTask (new Task(data.id, data.content))
    request.fail =>
      @noPickedTasks()

  markPickedTaskDone: () =>
    request = $.ajax '/tasks/done',
      'type': 'PUT'
    request.done  =>
      @markedPickedDone()

  pickTask: () =>
    request = $.get '/tasks/pick',
      'dataType': 'json'
    request.success (data) =>
      @taskPicked (new Task(data.id, data.content))

  taskAdded: () =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>

  fetchedPickedTask: (task) =>

  noPickedTasks: () =>

  markedPickedDone: () =>

  taskPicked: (task) =>
