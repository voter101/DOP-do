class TasksController < ApplicationController
  before_filter :authenticate_user!

  def create
    task_management_service.add(params[:data][:content])
    render status: :created, :nothing => true
  rescue TasksManagementService::ContentTooLongError
    render status: :bad_request, :nothing => true
  rescue TasksManagementService::SaveError
    render status: :forbidden, :nothing => true
  end

  def get_all
    tasks = task_management_service.get_all
    render :json => tasks
  end

  def get
    task = task_management_service.get(params[:id])
    render :json => task
  rescue TasksManagementService::TaskNotFoundError
    render status: :no_content, :nothing => true
  end

  def destroy
    task_management_service.destroy(params[:id])
    render status: :ok, :nothing => true
  rescue TasksManagementService::TaskDestroyError
    render status: :forbidden, :nothing => true
  end

  def pick
    render :json => task_picking_service.pick
  rescue TaskPickingService::NoTasksError
    render status: :no_content, :nothing => true
  end

  def get_picked
    render :json => task_picking_service.get_picked
  rescue TaskPickingService::NoTaskPickedError
    render status: :no_content, :nothing => true
  end

  def mark_picked_done
    task_picking_service.mark_picked_done
    render status: :ok, :nothing => true
  rescue TaskPickingService::NoTaskPickedError
    render status: :no_content, :nothing => true
  rescue TaskPickingService::SaveError
    render status: :internal_server_error, :nothing => true
  end

  private
  def task_repository
    TasksRepository.new
  end

  private
  def task_management_service
    validator = TasksValidator.new
    TasksManagementService.new(current_user, task_repository, validator)
  end

 private
 def task_picking_service
   TaskPickingService(current_user, task_repository)
 end

end