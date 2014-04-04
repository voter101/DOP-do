class TasksValidator
  class ContentTooLongError < StandardError; end

  attr_reader :task

  def initialize (task)
    @task = task
  end

  def validate
    raise ContentTooLongError.new unless @task.content.length > 3 && @task.content.length < 255
  end

end