class Task < ActiveRecord::Base
  validate do |task|
    TasksValidator.new(task).validate
  end

  self.table_name = "tasks"
end