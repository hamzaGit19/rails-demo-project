# frozen_string_literal: true

class Api::V1::ProjectsController < Api::V1::BaseController
  # before_action :authenticate_request!
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index]

  def index
    @projects = Project.all
    byebug
    render json: @projects
  end

  def create
    @project = Project.new(project_params.except(:employees))
    @project.creator_id = 16
    employee_ids = get_employee_ids
    add_employees(employee_ids)
  end

  def update
    employee_ids = get_employee_ids
    if employee_ids
      @project.employees.delete(@project.employees)
      add_employees(employee_ids)
    end
  end

  def show
    render json: @project
  end

  def destroy
    @project.destroy
  end

  def get_employee_ids
    employee_ids = project_params[:employees]
    employee_ids
  end

  def add_employees(employee_ids)
    employee_ids.each do |e_id|
      @employee = Employee.find(e_id)
      @project.employees << @employee
    end
  end

  def set_project
    @project = Project.find_by_id(params[:id])
    redirect_to(root_url, notice: 'Record not found') unless @project
  end

  def set_user
    # Please replace it when you add token and authorization. This is just placeholder to make things smoothly.
    @user = User.find_by_id(16)
    redirect_to(root_url, notice: 'Record not found') unless @user
  end

  def project_params
    params.require(:project).permit(:name, :description, :manager_id, :client_id, :creator_id, :cost, employees: [], files: [])
  end
end
