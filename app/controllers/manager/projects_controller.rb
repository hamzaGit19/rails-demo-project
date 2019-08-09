# frozen_string_literal: true

class Manager::ProjectsController < ProjectsController
  def create
    authorize(Project)
    super
    if @project.save
      redirect_to manager_projects_path, notice: 'Project was successfully created.'
    else
      render :new
     end
 end

  def update
    super
    authorize(@project)
    respond_to do |format|
      if @project.update(project_params.except(:employees))
        format.html { redirect_to manager_projects_path, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
    authorize(Project)
    super
    render 'projects/show', project: @project, _url: manager_project_path
  end

  def destroy 
    authorize(Project)
  end
  def authorize(record, query = nil)
    super([:manager, record], query)
  end
end
