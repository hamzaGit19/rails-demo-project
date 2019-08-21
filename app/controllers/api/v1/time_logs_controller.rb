# frozen_string_literal: true

class Api::V1::TimeLogsController < Api::V1::BaseController
  before_action :set_time_log, only: %i[show edit update destroy]
  before_action :set_project

  def index
    @time_logs = @project.time_logs
    render json: @time_logs
  end

  def show
    render json: @time_log
  end

  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.project_id = @project.id
    @time_log.creator_id = current_user.id
    if @time_log.save
      render_success('Successfully updated the project', @time_log)
    else
      render_errors(@time_log)
    end
  end

  def update
    if @time_log.update(time_log_params)
      render_success('Successfully updated the project', @time_log)
    else
      render_errors(@time_log)
    end
  end

  def destroy
    @time_log.destroy
    render json: { messgae: 'Destroyed time log' }
  end

  private

  def set_time_log
    @time_log = TimeLog.find_by_id(params[:id])
    render json: { notice: 'Record not found' } unless @time_log
  end

  def time_log_params
    params.require(:time_log).permit(:hours, :employee_id)
  end

  def set_project
    @project = Project.find_by_id(params[:project_id])
    render json: { notice: 'Record not found' } unless @project
  end

  def authorize(record, query = nil)
    super([:api, :v1, record], query)
  end
end
