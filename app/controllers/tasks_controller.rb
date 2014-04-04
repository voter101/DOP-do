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

  private
  def task_management_service
    task_repository = TasksRepository.new
    TasksManagementService.new(current_user, task_repository)
  end

end