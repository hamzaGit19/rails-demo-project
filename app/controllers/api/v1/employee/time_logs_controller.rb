class Api::V1::Employee::TimeLogsController < Api::V1::TimeLogsController
  def destroy
    # authorize(@time_log)
    super
    render json: { messgae: "Destroyed time log" }
  end

  def update
    # authorize(@time_log)
    super
    if @time_log.update(time_log_params)
      render json: @time_log
    else
      render json: { messgae: "Error updating the time log" }
    end
  end

  def index
    # authorize(TimeLog)
    super
  end

  def create
    # authorize(TimeLog)
    super
    if @time_log.save
      render json: @time_log
    else
      render json: { messgae: "Error updating the time log" }
    end
  end
end
