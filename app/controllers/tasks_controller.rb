class TasksController < ApplicationController

  def create
    begin
      task_service.add(params[:data][:content])
      render status: :created, :nothing => true
    rescue TaskContentTooLongError
      render status: :bad_request, :nothing => true
    rescue TaskSaveError
      render status: :forbidden, :nothing => true
    end
  end

  def show
    render :json => Task.all
  end

  def showItem
    begin
      task = Task.find(params[:id])
      render :json => task
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, :nothing => true
    end
  end

  def destroy
    begin
      TasksService.destroy(params[:id])
    rescue TaskDestroyError
      render status: :forbidden, :nothing => true
    end
  end

  private
  def task_service
    TasksService.new()
  end

end