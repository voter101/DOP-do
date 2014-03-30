class TasksRepository
  class TaskSaveError < StandardError; end

  attr_accessor :validator

  def initialize (validator)
    @validator = validator
  end

  def add (content, userId)
    task = Task.new
    task.content = content
    task.author = userId
    @validator.validateTask (task)
    if !task.save
      raise TaskSaveError.new
    end
  end

end