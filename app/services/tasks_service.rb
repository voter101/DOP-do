class TasksService
  class TaskContentTooLongError < StandardError; end
  class TaskSaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end
  class NoTaskPickedError < StandardError; end
  class NoTasksError < StandardError; end

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
    @taskRepository.pickTask(@user.id)
  rescue TasksRepository::NoTasksError
    raise NoTasksError
  end

  def markPickedAsDone
    if !@taskRepository.markPickedTaskDone(@user.id)
      raise TaskSaveError.new
    end
  rescue TasksRepository::NoTaskPickedError
    raise NoTaskPickedError.new
  end

  def getPicked
    task = @taskRepository.getPickedTask(@user.id)
    if task.nil?
      raise TaskNotPickedError.new
    end
    task
  end

end