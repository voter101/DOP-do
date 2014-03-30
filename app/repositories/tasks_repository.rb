class TasksRepository

  attr_accessor :validator

  def initialize (validator)
    @validator = validator
  end

end