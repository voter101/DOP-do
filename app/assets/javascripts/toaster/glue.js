var Glue;

Glue = (function() {

  function Glue(useCase, gui, tasksBackend, tasksOrdering) {
    var _this = this;
    this.useCase = useCase;
    this.gui = gui;
    this.tasksBackend = tasksBackend;
    this.tasksOrdering = tasksOrdering;
    After(this.useCase, "start", function() {
      return _this.gui.showTaskList();
    });
    After(this.useCase, "start", function() {
      return _this.tasksBackend.getTasks();
    });
    After(this.useCase, "addedTask", function(task) {
      return _this.gui.appendTask(task);
    });
    After(this.useCase, "removedTask", function(id) {
      return _this.gui.removeTask(id);
    });
    After(this.tasksBackend, "tasksFetched", function(tasks) {
      return _this.gui.setTasks(tasks);
    });
    After(this.tasksBackend, 'taskAdded', function(task) {
      return _this.useCase.addTask(task);
    });
    After(this.tasksBackend, 'taskRemoved', function(id) {
      return _this.useCase.removeTask(id);
    });
    After(this.gui, "taskSubmitted", function(content) {
      return _this.tasksBackend.addTask(content);
    });
    After(this.gui, "removeTaskClicked", function(id) {
      return _this.tasksBackend.removeTask(id);
    });
    LogAll(this.useCase);
    LogAll(this.gui);
    LogAll(this.tasksBackend);
    LogAll(this.tasksOrdering);
  }

  return Glue;

})();
