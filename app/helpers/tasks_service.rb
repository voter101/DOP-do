class TasksService
  class TaskContentTooLongError < StandardError; end
  class TaskSaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end
  class TaskAlreadyPickedError < StandardError; end

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def add(content)
    raise TaskContentTooLongError.new unless content.length > 3 && content.length < 255

    task = Task.new
    task.content = content
    task.author = @user.id

    if !task.save
      raise TaskSaveError.new
    end
  end

  def get(id)
    begin
      Task.find(id)
    rescue ActiveRecord::RecordNotFound
      raise TaskNotFoundError.new
    end
  end

  def getAll()
    Task.all
  end

  def destroy(id)
    task = Task.find(id)
    task.destroy()
    if !task.destroyed?
      raise TaskDestroyError.new
    end
  end

  def pickTask()
    raise TaskAlreadyPickedError.new if taskPicked?

    task = Task.first
    task.with_lock do
      task.picked_by = @user
      task.save!
    end
  end

  protected
  def taskPicked?()
    Task.where(picked_by: @user.id).count > 0
  end
end