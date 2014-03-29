class TasksListBackend

  constructor: ->
    @tasks = [
      {"id": 1, "content": "alfsdlkjfsljkfsdlkjfsdljkfsd"},
      {"id": 2, "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae molestie leo, sed condimentum risus. Phasellus auctor posuere nisi eu gravida. Ut euismod feugiat ipsum, vel auctor lorem congue ut. Ut cursus nisl non dictum fringilla. Integer at cursus urna."}
    ]

  getTasks: =>
    @tasksFetched @tasks

  addTask: (content) =>
    task = {id: 3, content: content}
    @tasks.add(task);
    @taskAdded task

  removeTask: (id) =>
    @tasks.remove( (task) ->
      parseInt(task.id) == parseInt(id)
    )
    @taskRemoved id

  taskAdded: (task) =>

  tasksFetched: (tasks) =>

  taskRemoved: (id) =>
