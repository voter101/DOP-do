var App;

App = (function() {

  function App() {
    var glue, gui, tasksBackend, tasksOrdering, useCase;
    useCase = new TasksList();
    gui = new Gui();
    tasksBackend = new TasksListBackend();
    tasksOrdering = new TasksListOrdering();
    glue = new Glue(useCase, gui, tasksBackend, tasksOrdering);
    useCase.start();
  }

  return App;

})();
