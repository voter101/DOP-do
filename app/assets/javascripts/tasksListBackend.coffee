class @TasksListBackend
  fetchTasks: () =>
    request = $.get '/tasks.json',
      dataType: 'json'
    request.success (data) =>
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
      @fetchedPickedTask data
    request.fail =>
      @noPickedTaskFetched()

  markPickedTaskDone: () =>
    request = $.ajax '/task/done',
      'type': 'PUT'
    request.done  =>
      @markedPickedDone()

  taskAdded: () =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>

  fetchedPickedTask: (task) =>

  noPickedTaskFetched

  markedPickedDone: () =>
