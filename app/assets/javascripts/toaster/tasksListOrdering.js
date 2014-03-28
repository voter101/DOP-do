var TasksListOrdering,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TasksListOrdering = (function() {

  function TasksListOrdering() {
    this.changeOrder = __bind(this.changeOrder, this);
    this.tasksOrder = [];
  }

  TasksListOrdering.prototype.changeOrder = function(tasksOrder) {
    this.tasksOrder = tasksOrder;
  };

  return TasksListOrdering;

})();
