# frozen_string_literal: true

class Admin::TimeLogsController < TimeLogsController
  def new
    authorize(TimeLog)
    super
  end

  def destroy
    authorize(@time_log)
    super

    redirect_to admin_project_time_logs_path(@project), notice: 'time_log was successfully destroyed.'
  end

  def update
    authorize(@time_log)
    super

    if @time_log.update(time_log_params.except(:employees))
      redirect_to admin_project_time_logs_path(@project), notice: 'time_log was successfully updated.'
    else
      render :edit
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
    if @time_log.save
    else
      render :new
    end
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
