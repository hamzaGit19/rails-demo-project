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
    @project.creator_id = @current_user.id
    employee_ids = get_employee_ids
    add_employees(employee_ids)
    if @project.save(project_params.except(:employees))
      render_success('Successfully updated the project', @project)
    else
      render_errors(@project)
    end
  end

  def update
    employee_ids = get_employee_ids
    if employee_ids
      @project.employees.delete(@project.employees)
      add_employees(employee_ids)
    end
    if @project.update(project_params.except(:employees))
      render_success('Successfully updated the project', @project)
    else
      render_errors(@project)
    end
  end

  def show
    render json: @project
  end

  def destroy
    @project.destroy
    render json: { message: 'Deleted project.' }
  end

  def get_employee_ids
    employee_ids = project_params[:employees]
    employee_ids
  end

  def add_employees(employee_ids)
    employee_ids&.each do |e_id|
      @employee = Employee.find(e_id)
      @project.employees << @employee
    end
  end

  def set_project
    @project = Project.find_by_id(params[:id])
    render not_found unless @project
  end

  def set_user
    @user = User.find_by_id(@current_user.id)
    render not_found unless @user
  end

  def project_params
    params.require(:project).permit(:name, :description, :manager_id, :client_id, :creator_id, :cost, employees: [], files: [])
  end

  def validate_user
    render json: { erro: 'You are not authorized to perform this action' } if @current_user.employee?
  end

  def authorize(record, query = nil)
    super([:api, :v1, record], query)
  end
end
