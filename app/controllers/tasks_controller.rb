class TasksController < ApplicationController
  before_filter :authenticate_user!

  def create
    task_service.add(params[:data][:content])
    render status: :created, :nothing => true
  rescue TasksService::TaskContentTooLongError
    render status: :bad_request, :nothing => true
  rescue TasksService::TaskSaveError
    render status: :forbidden, :nothing => true
  end

  def showAll
    tasks = task_service.getAll()
    render :json => tasks
  end

  def showItem
    task = task_service.getItem(params[:id])
    render :json => task
  rescue TasksService::TaskNotFoundError
    render status: :not_found, :nothing => true
  end

  def destroy
    task_service.destroy(params[:id])
    render status: :ok, :nothing => true
  rescue TasksService::TaskDestroyError
    render status: :forbidden, :nothing => true
  end

  def pick
    render :json => task_service.pick()
  rescue TasksService::NoTasksError
    render status: :not_found, :nothing => true
  end

  def getPicked
    task = task_service.getPicked()
    render :json => task
  rescue TasksService::TaskNotPickedError
    render status: :not_found, :nothing => true
  end

  def markPickedAsDone
    task_service.markPickedAsDone()
    render status: :ok, :nothing => true
  rescue TasksService::NoTaskPickedError
    render status: :not_found, :nothing => true
  rescue TasksService::TaskSaveError
    render status: :not_found, :nothing => true
  end

  private
  def task_service
    validator = TasksValidator.new
    repository = TasksRepository.new(validator)
    TasksService.new(current_user, repository)
  end

end