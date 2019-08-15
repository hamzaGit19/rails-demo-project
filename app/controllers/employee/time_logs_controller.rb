# frozen_string_literal: true

class Employee::TimeLogsController < TimeLogsController
  def new
    super
  end

  def destroy
    super
    redirect_to employee_project_time_logs_path(@project), notice: 'time_log was successfully destroyed.'
  end

  def update
    super

    if @time_log.update(time_log_params.except(:employees))
      redirect_to employee_project_time_logs_path(@project), notice: 'time_log was successfully updated.'
    else
      render :edit
    end
  end

  def create
    super
    if @time_log.save
    else
      render :new
    end
  end
end
