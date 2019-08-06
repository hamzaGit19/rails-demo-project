# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_time_log, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new show edit update destroy create]

  # GET /time_logs
  # GET /time_logs.json
  def index
    @time_logs = @project.time_logs
  end

  # GET /time_logs/1
  # GET /time_logs/1.json
  def show; end

  # GET /time_logs/new
  def new
    @time_log = TimeLog.new
  end

  # GET /time_logs/1/edit
  def edit; end

  # POST /time_logs
  # POST /time_logs.json
  def create
    @time_log = TimeLog.new(time_log_params)
    @time_log.project_id = @project.id
    @time_log.creator_id = current_user.id
  end

  # PATCH/PUT /time_logs/1
  # PATCH/PUT /time_logs/1.json
  def update; end

  # DELETE /time_logs/1
  # DELETE /time_logs/1.json
  def destroy
    @time_log.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_time_log
    @time_log = TimeLog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def time_log_params
    params.require(:time_log).permit(:hours, :employee_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
