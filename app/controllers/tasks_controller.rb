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

  def get_all
    tasks = task_service.get_all
    render :json => tasks
  end

  def get
    task = task_service.get(params[:id])
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
    render :json => task_service.pick
  rescue TasksService::NoTasksError
    render status: :not_found, :nothing => true
  end

  def get_picked
    task = task_service.get_picked
    render :json => task
  rescue TasksService::TaskNotPickedError
    render status: :not_found, :nothing => true
  end

  def mark_picked_done
    task_service.mark_picked_done
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