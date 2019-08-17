# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index]

  def index
    @projects = if params[:title]
                  params.merge!(role: current_user.type, user_id: current_user.id)
                  Project.apply_filters(params)
                else
                  @projects = if current_user.employee?
                                @user.projects
                              else
                                Project.all
                              end
                end
  end

  def show
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
    byebug
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
    @project.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find_by_id(params[:id])
    redirect_to(root_url, notice: "Record not found") unless @project
  end

  def set_user
    @user = User.find_by_id(current_user.id)
    redirect_to(root_url, notice: "Record not found") unless @user
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
    byebug
    employee_ids.each do |e_id|
      # unless @project.employees.exists?(id: e_id)
      byebug
      @employee = Employee.find(e_id)
      @project.employees << @employee
      # end
    end
  end
end
