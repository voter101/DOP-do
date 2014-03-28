var TasksList,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TasksList = (function() {

  function TasksList() {
    this.removedTask = __bind(this.removedTask, this);

    this.removeTask = __bind(this.removeTask, this);

    this.taskNotAdded = __bind(this.taskNotAdded, this);

    this.taskAdded = __bind(this.taskAdded, this);

    this.addTask = __bind(this.addTask, this);

    this.start = __bind(this.start, this);
    this.tasks = [];
  }

  TasksList.prototype.start = function() {};

  TasksList.prototype.addTask = function(task) {
    this.tasks[task.id] = task;
    return this.taskAdded(task);
  };

  TasksList.prototype.taskAdded = function(task) {
    return task;
  };

  TasksList.prototype.taskNotAdded = function() {
    return console.warn("Failed to add task");
  };

  TasksList.prototype.removeTask = function(id) {
    this.tasks.remove(function(task) {
      return parseInt(task.id) === parseInt(id);
    });
    return this.removedTask(id);
  };

  TasksList.prototype.removedTask = function(id) {};

  return TasksList;

})();
