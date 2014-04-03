class TasksController < ApplicationController
  before_filter :authenticate_user!

  def create
    task_service.add(params[:data][:content])
    render status: :created, :nothing => true
  rescue TasksService::ContentTooLongError
    render status: :bad_request, :nothing => true
  rescue TasksService::SaveError
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
    render status: :no_content, :nothing => true
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
    render status: :no_content, :nothing => true
  end

  def get_picked
    task = task_service.get_picked
    render :json => task
  rescue TasksService::NoTaskPickedError
    render status: :no_content, :nothing => true
  end

  def mark_picked_done
    task_service.mark_picked_done
    render status: :ok, :nothing => true
  rescue TasksService::NoTaskPickedError
    render status: :no_content, :nothing => true
  rescue TasksService::SaveError
    render status: :internal_server_error, :nothing => true
  end

  private
  def task_service
    validator = TasksValidator.new
    repository = TasksRepository.new
    TasksService.new(current_user, repository, validator)
  end

end