class TasksValidator
  class TaskContentTooLongError < StandardError; end

  def validateTask (task)
    raise TaskContentTooLongError.new unless content.length > 3 && content.length < 255
  end

end