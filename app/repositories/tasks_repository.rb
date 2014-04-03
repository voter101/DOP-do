class TasksRepository
  class NoTasksError < StandardError; end
  class NoTaskPickedError < StandardError; end


  def add (task)
    task.save
  end

  def get(id)
    Task.find(id)
  end

  def get_all
    Task.where(picked_by: nil, done: false)
  end

  def get_unpicked
    Task.where(done: false).lock(true).first
  end

  def destroy(id)
    task = get(id)
    task.destroy
    task.destroyed?
  end

  def pick(user_id)
    task = get_picked(user_id)
    if task.nil?
      Task.transaction do
        task = get_unpicked
        raise NoTasksError.new if task.nil?
        task.picked_by = user_id
        task.save
      end
    end

    task
  end

  def mark_picked_done(user_id)
    task = get_picked(user_id)
    raise NoTaskPickedError.new if task.nil?
    task.done = true
    task.save
  end

  def get_picked(user_id)
    Task.where(picked_by: user_id, done: false).first
  end

end