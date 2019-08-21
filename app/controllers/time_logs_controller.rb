# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_time_log, only: %i[show edit update destroy]
  before_action :set_project

  def index
    @time_logs = @project.time_logs
  end

  def show; end

  def new
    @time_log = TimeLog.new
  end

  def edit; end

  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.project_id = @project.id
    @time_log.creator_id = current_user.id
  end

  def update; end

  def destroy
    @time_log.destroy
  end

  private

  def set_time_log
    @time_log = TimeLog.find_by_id(params[:id])
    redirect_to(root_url, notice: 'Record not found') unless @time_log
  end

  def time_log_params
    params.require(:time_log).permit(:hours, :employee_id)
  end

  def set_project
    @project = Project.find_by_id(params[:project_id])
    redirect_to(root_url, notice: 'Record not found') unless @project
  end
end
