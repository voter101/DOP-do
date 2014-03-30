class TasksRepository
  class TaskSaveError < StandardError; end
  class TaskDestroyError < StandardError; end

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

  def getTask(id)
    Task.find(id)
  end

  def getAll
    Task.where(picked_by: nil, done: false)
  end

  def destroy(id)
    task = Task.find(id)
    task.destroy()
    raise TaskDestroyError.new unless task.destroyed?
  end

end