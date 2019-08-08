# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index]

  # GET /projects
  # GET /projects.json
  def index
    @projects = if params[:title]
                  params.merge!(role: current_user.type, user_id: current_user.id)
                  Project.apply_filters(params)
                else
                  if current_user.employee?
                    @projects = @user.projects
                  elsif current_user.manager?
                    @projects = Project.all
                  end
                end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    authorize @project, :is_allowed?, policy_class: ProjectPolicy

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name" # Excluding ".pdf" extension.
      end
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params.except(:employees))
    @project.creator_id = current_user.id
    employee_ids = get_employee_ids
    add_employees(employee_ids)
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project.employees.delete(@project.employees)
    employee_ids = get_employee_ids

    add_employees(employee_ids)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    authorize User, :is_admin?, policy_class: ProjectPolicy
    @project.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    if Project.exists?(id: params[:id])
      @project = Project.find(params[:id])
    else
      redirect_to dashboard_root_path, notice: "Project does not exist."
    end
  end
  def set_user
    @user = User.find(current_user.id)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :description, :manager_id, :client_id, :creator_id, :cost, employees: [], files: [])
  end

  def get_employee_ids
    employee_ids = project_params[:employees]
    employee_ids.delete("")
    employee_ids
  end

  def add_employees(employee_ids)
    employee_ids.each do |e_id|
      unless @project.employees.exists?(id: e_id)
        @employee = Employee.find(e_id)
        @project.employees << @employee
      end
    end
  end
end
