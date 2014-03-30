class TasksRepository
  class TaskSaveError < StandardError;  end
  class TaskDestroyError < StandardError;  end
  class NoTasksError < StandardError;  end
  class NoTaskPickedError < StandardError;  end

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

  def pickTask(userId)
    pickedTask = getPickedTask(userId)
    if pickedTask.nil?
      Task.transaction do
        task = Task.where(done: false).lock(true).first
        if (task.nil?)
          raise NoTasksError.new
        end
        task.picked_by = userId
        task.save
        pickedTask = task
      end
    end
    return pickedTask
  end

  def markPickedTaskDone(userId)
    task = getPickedTask(userId)
    if task.nil?
      raise NoTaskPickedError.new
    end
    task.done = true
    task.save
  end

  def getPickedTask(userId)
    Task.where(picked_by: userId, done: false).first
  end

end