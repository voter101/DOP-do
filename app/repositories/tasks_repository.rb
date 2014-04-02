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
    @validator.validate_task (task)
    if !task.save
      raise TaskSaveError.new
    end
  end

  def get(id)
    Task.find(id)
  end

  def get_all
    Task.where(picked_by: nil, done: false)
  end

  def destroy(id)
    task = Task.find(id)
    task.destroy()
    raise TaskDestroyError.new unless task.destroyed?
  end

  def pick(userId)
    task = get_picked(userId)
    if task.nil?
      Task.transaction do
        task = Task.where(done: false).lock(true).first
        if (task.nil?)
          raise NoTasksError.new
        end
        task.picked_by = userId
        task.save
      end
    end
    return task
  end

  def mark_picked_done(userId)
    task = get_picked(userId)
    if task.nil?
      raise NoTaskPickedError.new
    end
    task.done = true
    task.save
  end

  def get_picked(userId)
    Task.where(picked_by: userId, done: false).first
  end

end