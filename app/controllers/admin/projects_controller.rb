# frozen_string_literal: true

class Admin::ProjectsController < ProjectsController
  def create
    # authorize(Project)
    super
    if @project.save(project_params.except(:employees))
      redirect_to admin_project_path(@project), notice: 'Project was successfully created.'
    else
      render :new
   end
  end

  def update
    authorize(@project)
    super

    if @project.update(project_params.except(:employees))
      redirect_to admin_projects_index_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize(@project)
    super

    redirect_to admin_projects_index_path, notice: 'Project was successfully destroyed.'
  end

  def show
    super
    authorize(@project)
    respond_to do |format|
      format.html { render 'projects/show', project: @project, _url: admin_project_path }
      format.pdf do
        render pdf: 'Your_filename',
               template: 'projects/show.html.erb',
               layout: 'pdf.html'
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
