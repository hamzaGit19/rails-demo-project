# frozen_string_literal: true

class Admin::TimeLogsController < TimeLogsController
  def new
    super
    end

  def destroy
    super
    respond_to do |format|
      format.html { redirect_to admin_project_time_logs_path(@project), notice: 'time_log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    super
    respond_to do |format|
      if @time_log.update(time_log_params.except(:employees))
        format.html { redirect_to admin_project_time_logs_path(@project), notice: 'time_log was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    super
    respond_to do |format|
      if @time_log.save
        format.html { redirect_to admin_project_time_logs_path(@project), notice: 'time_log was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
end
