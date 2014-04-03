class TasksRepository
  class NoTasksError < StandardError; end
  class NoTaskPickedError < StandardError; end


  def add (task)
    return task.save
  end

  def get(id)
    Task.find(id)
  end

  def get_all
    Task.where(picked_by: nil, done: false)
  end

  def get_unpicked
    task = Task.where(done: false).lock(true).first
  end

  def destroy(id)
    task = get(id)
    task.destroy()
    return task.destroyed?
  end

  def pick(userId)
    task = get_picked(userId)
    if task.nil?
      Task.transaction do
        task = get_unpicked
        if task.nil?
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