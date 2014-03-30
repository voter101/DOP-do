class TasksService
  class TaskContentTooLongError < StandardError; end
  class TaskSaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end
  class TaskNotPickedError < StandardError; end
  class TaskNoTasksError < StandardError; end

  attr_reader :user, :taskRepository

  def initialize(user, taskRepository)
    @user = user
    @taskRepository = taskRepository
  end

  def add(content)
    @taskRepository.add(content, @user.id)
  rescue TasksValidator::TaskContentTooLongError
    raise TaskContentTooLongError.new
  rescue TasksRepository::TaskSaveError
    raise TaskSaveError.new
  end

  def getItem(id)
    @taskRepository.getTask(id)
  rescue ActiveRecord::RecordNotFound
    raise TaskNotFoundError.new
  end

  def getAll
    @taskRepository.getAll
  rescue ActiveRecord::RecordNotFound
    raise TaskNotFoundError.new
  end

  def destroy(id)
    @taskRepository.destroy(id)
  rescue TasksRepository::TaskDestroyError
    raise TaskDestroyError
  end

  def pick
    begin
      pickedTask = getPicked()
      return pickedTask
    rescue TaskNotPickedError; end

    Task.transaction do
      task = Task.where(done: false).lock(true).first
      if (task.nil?)
        raise TaskNoTasksError
      end
      task.picked_by = @user.id
      task.save!
    end
    return getPicked
  end

  def markPickedAsDone()
    pickedTask = getPicked()
    pickedTask.done = true
    pickedTask.save
  end

  def getPicked()
    task = Task.where(picked_by: @user.id, done: false).first
    if task.nil?
      raise TaskNotPickedError.new
    end
    return task
  end

end