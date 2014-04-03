class TaskPickingService
  class SaveError < StandardError; end
  class NoTasksError < StandardError; end
  class NoTaskPickedError < StandardError; end

  attr_reader :user, :repository

  def initialize(user, task_repository)
    @user = user
    @repository = task_repository
  end

  def pick
    @repository.pick(@user.id)
  rescue TasksRepository::NoTasksError
    raise NoTasksError
  end

  def mark_picked_done
    raise SaveError unless @repository.mark_picked_done(@user.id)
  rescue TasksRepository::NoTaskPickedError
    raise NoTaskPickedError.new
  end

  def get_picked
    task = @repository.get_picked(@user.id)
    raise NoTaskPickedError.new if task.nil?
    task
  end
end