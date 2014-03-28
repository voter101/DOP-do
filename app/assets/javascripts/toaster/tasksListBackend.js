var TasksListBackend,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TasksListBackend = (function() {

  function TasksListBackend() {
    this.taskRemoved = __bind(this.taskRemoved, this);

    this.tasksFetched = __bind(this.tasksFetched, this);

    this.taskAdded = __bind(this.taskAdded, this);

    this.removeTask = __bind(this.removeTask, this);

    this.addTask = __bind(this.addTask, this);

    this.getTasks = __bind(this.getTasks, this);
    this.tasks = [
      {
        "id": 1,
        "content": "alfsdlkjfsljkfsdlkjfsdljkfsd"
      }, {
        "id": 2,
        "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae molestie leo, sed condimentum risus. Phasellus auctor posuere nisi eu gravida. Ut euismod feugiat ipsum, vel auctor lorem congue ut. Ut cursus nisl non dictum fringilla. Integer at cursus urna."
      }
    ];
  }

  TasksListBackend.prototype.getTasks = function() {
    return this.tasksFetched(this.tasks);
  };

  TasksListBackend.prototype.addTask = function(content) {
    var task;
    task = {
      id: 3,
      content: content
    };
    this.tasks.add(task);
    return this.taskAdded(task);
  };

  TasksListBackend.prototype.removeTask = function(id) {
    this.tasks.remove(function(task) {
      return parseInt(task.id) === parseInt(id);
    });
    return this.taskRemoved(id);
  };

  TasksListBackend.prototype.taskAdded = function(task) {};

  TasksListBackend.prototype.tasksFetched = function(tasks) {};

  TasksListBackend.prototype.taskRemoved = function(id) {};

  return TasksListBackend;

})();
