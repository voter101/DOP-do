class TasksController < ApplicationController

  def create
    begin
      task_service.add(params[:data][:content])
      render status: :created, :nothing => true
    rescue TasksService::TaskContentTooLongError
      render status: :bad_request, :nothing => true
    rescue TasksService::TaskSaveError
      render status: :forbidden, :nothing => true
    end
  end

  def show
    tasks = task_service.getAll()
    render :json => Task.all
  end

  def showItem
    begin
      task = task_service.get(params[:id])
      render :json => task
    rescue TasksService::TaskNotFoundError
      render status: :not_found, :nothing => true
    end
  end

  def destroy
    begin
      task_service.destroy(params[:id])
      render status: :ok, :nothing => true
    rescue TasksService::TaskDestroyError
      render status: :forbidden, :nothing => true
    end
  end

  private
  def task_service
    TasksService.new()
  end

end