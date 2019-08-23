# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index]

  def index
    @projects = Project.apply_filter(params, @current_user)
    @projects = @projects.page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name" # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params.except(:employees))
    @project.creator_id = current_user.id
    @project.add_employees(project_params)
  end

  def update
    @project.add_employees(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
    redirect_to(root_url, notice: "Record not found") unless @project
  end

  def set_user
    @user = User.find_by_id(current_user.id)
    redirect_to(root_url, notice: "Record not found") unless @user
  end

  def project_params
    params.require(:project).permit(:name, :description, :manager_id, :client_id, :creator_id, :cost, employees: [], files: [])
  end
end
