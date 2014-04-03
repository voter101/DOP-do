class TasksValidator
  class ContentTooLongError < StandardError; end

  def validate_task (task)
    raise ContentTooLongError.new unless task.content.length > 3 && task.content.length < 255
  end

end