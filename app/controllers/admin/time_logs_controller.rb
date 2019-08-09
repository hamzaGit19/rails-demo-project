# frozen_string_literal: true

class Admin::TimeLogsController < TimeLogsController
  def new
    authorize(TimeLog)
    super
  end

  def destroy
    authorize(@time_log)
    super
    respond_to do |format|
      format.html { redirect_to admin_project_time_logs_path(@project), notice: "time_log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    authorize(@time_log)
    super
    respond_to do |format|
      if @time_log.update(time_log_params.except(:employees))
        format.html { redirect_to admin_project_time_logs_path(@project), notice: "time_log was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def index
    authorize(TimeLog)
    super
  end

  def new
    authorize(TimeLog)
    super
  end

  def create
    authorize(TimeLog)
    super
    respond_to do |format|
      if @time_log.save
        format.js
        format.html { redirect_to admin_project_time_logs_path(@project), notice: "time_log was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
