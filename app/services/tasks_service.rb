class TasksService
  class ContentTooLongError < StandardError; end
  class SaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end
  class NoTaskPickedError < StandardError; end
  class NoTasksError < StandardError; end

  attr_reader :user, :repository, :validator

  def initialize(user, taskRepository, taskValidator)
    @user = user
    @repository = taskRepository
    @validator = taskValidator
  end

  def add(content)
    task = Task.new
    task.content = content
    task.author = user.id
    raise SaveError unless @repository.add(task)
  rescue TasksValidator::ContentTooLongError
    raise ContentTooLongError.new
  end

  def get(id)
    result = @repository.get(id)
    raise TaskNotFoundError if result.nil?
    return result
  end

  def get_all
    @repository.get_all
  end

  def destroy(id)
    raise TaskDestroyError unless @repository.destroy(id)
  end

  def pick
    @repository.pick(@user.id)
  rescue TasksRepository::NoTasksError
    raise NoTasksError
  end

  def mark_picked_done
    raise TaskSaveError unless @repository.mark_picked_done(@user.id)
  rescue TasksRepository::NoTaskPickedError
    raise NoTaskPickedError.new
  end

  def get_picked
    task = @repository.get_picked(@user.id)
    raise TaskNotPickedError.new if task.nil?
    task
  end

end