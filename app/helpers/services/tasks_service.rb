class TasksService
  class TaskContentTooLongError < StandardError; end

  def addTask(content)
    raise TaskContentTooLongError.new unless content.length > 3 && content.length < 255

    task = Task.new
    task.content = content
    task.save
  end

end