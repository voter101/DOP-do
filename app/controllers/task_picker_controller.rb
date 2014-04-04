class TaskPickerController < ApplicationController
  before_filter :authenticate_user!

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
  def task_picking_service
    task_repository = TasksRepository.new
    TaskPickingService.new(current_user, task_repository)
  end
end