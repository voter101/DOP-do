class TasksService
  class TaskContentTooLongError < StandardError; end
  class TaskSaveError < StandardError; end
  class TaskDestroyError < StandardError; end

  #attr_reader :user

  #def initialize(user)
  #  @user = user
  #end

  def add(content)
    raise TaskContentTooLongError.new unless content.length > 3 && content.length < 255

    task = Task.new
    task.content = content
    #task.author = @user.id
    task.author = "123"

    if !task.save
      raise TaskSaveError.new
    end
  end

  def destroy(id)
    task = Task.find(id)
    task.destroy()
    if !task.destroyed?
      raise TaskDestroyError.new
    end
  end
end