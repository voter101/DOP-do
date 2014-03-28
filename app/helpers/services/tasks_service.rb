class TasksService
  class TaskContentTooLongError < StandardError; end

  def addTask(content)
    raise TaskContentTooLongError.new unless content.length > 3

    task = Task.new
    task.content = content
    task.save
  end

end