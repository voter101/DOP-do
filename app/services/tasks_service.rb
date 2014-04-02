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

  def get(id)
    @taskRepository.get(id)
  rescue ActiveRecord::RecordNotFound
    raise TaskNotFoundError.new
  end

  def get_all
    @taskRepository.get_all
  rescue ActiveRecord::RecordNotFound
    raise TaskNotFoundError.new
  end

  def destroy(id)
    @taskRepository.destroy(id)
  rescue TasksRepository::TaskDestroyError
    raise TaskDestroyError
  end

  def pick
    @taskRepository.pick(@user.id)
  rescue TasksRepository::NoTasksError
    raise NoTasksError
  end

  def mark_picked_done
    if !@taskRepository.mark_picked_done(@user.id)
      raise TaskSaveError.new
    end
  rescue TasksRepository::NoTaskPickedError
    raise NoTaskPickedError.new
  end

  def get_picked
    task = @taskRepository.get_picked(@user.id)
    if task.nil?
      raise TaskNotPickedError.new
    end
    task
  end

end