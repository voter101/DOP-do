class TasksManagementService
  class ContentTooLongError < StandardError; end
  class SaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end

  attr_reader :user, :repository

  def initialize(user, task_repository)
    @user = user
    @repository = task_repository
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
    result
  end

  def get_all
    @repository.get_all
  end

  def destroy(id)
    raise TaskDestroyError unless @repository.destroy(id)
  end
end