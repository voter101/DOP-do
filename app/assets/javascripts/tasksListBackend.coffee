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
    request = $.get '/tasks/picked',
      dataType: 'json'
    request.done (data, textStatus, jqXHR) =>
      return @noTaskPicked() unless jqXHR.status == 200
      @fetchedPickedTask(new Task(data.id, data.content))
    request.fail () =>
        @noTaskPicked()

  markPickedTaskDone: () =>
    request = $.ajax '/tasks/picked/done',
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

  noTaskPicked: () =>

  markedPickedDone: () =>

  taskPicked: (task) =>
