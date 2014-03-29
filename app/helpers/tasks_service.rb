class TasksService
  class TaskContentTooLongError < StandardError; end
  class TaskSaveError < StandardError; end
  class TaskNotFoundError < StandardError; end
  class TaskDestroyError < StandardError; end
  class TaskNotPickedError < StandardError; end

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
    Task.where("picked_by IS NULL")
  end

  def destroy(id)
    task = Task.find(id)
    task.destroy()
    raise TaskDestroyError.new unless task.destroyed?
  end

  def pick()
    begin
      pickedTask = getPicked()
      return pickedTask
    rescue TaskNotPickedError; end

    task = Task.first
    task.with_lock do
      task.picked_by = @user
      task.save!
    end
    return task
  end

  def getPicked()
    task = Task.where(picked_by: @user.id)
    if task.empty?
      raise TaskNotPickedError.new
    end
    return task
  end

end