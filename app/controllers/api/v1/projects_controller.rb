# frozen_string_literal: true

class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index]
  before_action :validate_user, only: %i[update create]

  def index
    @projects = Project.apply_filter(params, @current_user)
    render json: @projects
  end

  def create
    @project = Project.new(project_params.except(:employees))
    @project.creator_id = current_user.id
    @project.add_employees(project_params)

    if @project.save(project_params.except(:employees))
      render_success("Successfully updated the project", @project)
    else
      render_errors(@project)
    end
  end

  def update
    @project.add_employees(project_params)
    if @project.update(project_params.except(:employees))
      render_success("Successfully updated the project", @project)
    else
      render_errors(@project)
    end
  end

  def show
    render json: @project
  end

  def destroy
    @project.destroy
    render json: { message: "Deleted project." }
  end

  def set_project
    @project = Project.find(params[:id])
    render not_found unless @project
  end

  def set_user
    @user = User.find(@current_user.id)
  end

  def project_params
    params.require(:project).permit(:name, :description, :manager_id, :client_id, :creator_id, :cost, employees: [], files: [])
  end

  def validate_user
    render json: { erro: "You are not authorized to perform this action" } if @current_user.employee?
  end

  def authorize(record, query = nil)
    super([:api, :v1, record], query)
  end
end
