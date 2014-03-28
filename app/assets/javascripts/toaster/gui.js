var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.removeTaskClicked = __bind(this.removeTaskClicked, this);

    this.taskSubmitted = __bind(this.taskSubmitted, this);

    this.taskSubmit = __bind(this.taskSubmit, this);

    this.removeTaskClick = __bind(this.removeTaskClick, this);

    this.removeTask = __bind(this.removeTask, this);

    this.appendTask = __bind(this.appendTask, this);

    this.setTasks = __bind(this.setTasks, this);

    this.showTaskList = __bind(this.showTaskList, this);

    this.createElementFor = __bind(this.createElementFor, this);

  }

  Gui.prototype.createElementFor = function(templateId, data) {
    var element, html, source, template;
    source = $(templateId).html();
    template = Handlebars.compile(source);
    html = template(data);
    return element = $(html);
  };

  Gui.prototype.showTaskList = function() {
    var form, list;
    list = this.createElementFor("#TasksListTemplate");
    form = this.createElementFor("#TaskForm");
    $('.main').append(list);
    $('.main').append(form);
    form.submit(this.taskSubmit);
    return $('.tasksList').on('click', '.removeTask', this.removeTaskClick);
  };

  Gui.prototype.setTasks = function(tasks) {
    var _this = this;
    $('.tasksList div').empty();
    return tasks.map(function(task) {
      return _this.appendTask(task);
    });
  };

  Gui.prototype.appendTask = function(task) {
    var element;
    element = this.createElementFor('#TaskTemplate', task);
    return $('.tasksList').append(element);
  };

  Gui.prototype.removeTask = function(id) {
    console.log(id);
    return $('.tasksList .task[data-taskId=' + id + ']').slideUp();
  };

  Gui.prototype.removeTaskClick = function(event) {
    var id;
    id = $(event.target).attr('data-taskId');
    return this.removeTaskClicked(id);
  };

  Gui.prototype.taskSubmit = function(event) {
    var content, contentInput;
    event.preventDefault();
    contentInput = $(event.target).find('[name=content]');
    content = contentInput.val();
    contentInput.val('');
    if (content.length > 3) {
      return this.taskSubmitted(content);
    }
  };

  Gui.prototype.taskSubmitted = function(content) {};

  Gui.prototype.removeTaskClicked = function(id) {};

  return Gui;

})();
