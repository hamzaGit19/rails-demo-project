# frozen_string_literal: true

class Admin::ProjectsController < ProjectsController
  def create
    authorize(Project)
    super
    if @project.save
      redirect_to admin_projects_index_path, notice: "Project was successfully created."
    else
      render :new
    end
  end

  def update
    authorize(@project)
    super
    respond_to do |format|
      if @project.update(project_params.except(:employees))
        format.html { redirect_to admin_projects_index_path, notice: "Project was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize(@project)
    super
    respond_to do |format|
      format.html { redirect_to admin_projects_index_path, notice: "Project was successfully destroyed." }
    end
  end

  def show
    super
    authorize(@project)
    respond_to do |format|
      format.html { render "projects/show", project: @project, _url: admin_project_path }
      format.pdf do
        render pdf: "Your_filename",
               template: "projects/show.html.erb",
               layout: "pdf.html"
      end
    end
  end

  def index
    authorize(Project)
    super
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
