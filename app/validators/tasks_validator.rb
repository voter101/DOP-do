class TasksValidator
  class TaskContentTooLongError < StandardError; end

  def validateTask (task)
    raise TaskContentTooLongError.new unless task.content.length > 3 && task.content.length < 255
  end

end