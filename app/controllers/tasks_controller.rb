class TasksController < ApplicationController

  def create
    task_service.addTask(params[:content])
  end

  def show
    render json: Task.find()
  end

  private def task_service
    TasksService.new(current_user)
  end

end