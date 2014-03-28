class TasksController < ApplicationController

  def create
    task_service.addTask(params[:content])
  end

  def show

  end

  private def task_service
    TasksService.new(current_user)
  end

end