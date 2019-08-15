# frozen_string_literal: true

class Manager::TimeLogsController < TimeLogsController
  def new
    authorize(TimeLog)
    super
  end

  def destroy
    authorize(TimeLog)
    super
    redirect_to manager_project_time_logs_path(@project), notice: 'time_log was successfully destroyed.'
  end

  def update
    super
    authorize(@time_log)
    if @time_log.update(time_log_params.except(:employees))
      redirect_to manager_project_time_logs_path(@project), notice: 'time_log was successfully updated.'
    else
      render :edit
    end
  end

  def create
    authorize(TimeLog)
    super
    if @time_log.save
    else
      render :new
    end
  end

  def authorize(record, query = nil)
    super([:manager, record], query)
  end
end
