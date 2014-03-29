class TasksController < ApplicationController

  def create
    task_service.addTask(params[:data][:content])
    render status: :created, :nothing => true
  end

  def show
    render :json => Task.all
  end

  def showItem
    render :json => Task.find(params[:id])
  end

  private
  def task_service
    TasksService.new()
  end

end