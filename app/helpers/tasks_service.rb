class TasksService
  class TaskContentTooLongError < StandardError; end

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
    task.save
  end
end