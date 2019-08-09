# frozen_string_literal: true

class Manager::TimeLogsController < TimeLogsController
  def new
    authorize(TimeLog)
    super
  end

  def destroy
    authorize(TimeLog)
    super
    respond_to do |format|
      format.html { redirect_to manager_project_time_logs_path(@project), notice: "time_log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    super
    authorize(@time_log)
    respond_to do |format|
      if @time_log.update(time_log_params.except(:employees))
        format.html { redirect_to manager_project_time_logs_path(@project), notice: "time_log was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    authorize(TimeLog)
    super
    respond_to do |format|
      if @time_log.save
        format.js
        format.html { redirect_to manager_project_time_logs_path(@project), notice: "time_log was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def authorize(record, query = nil)
    super([:manager, record], query)
  end
end
