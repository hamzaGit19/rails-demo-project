class Api::V1::Admin::ProjectsController < Api::V1::ProjectsController
  def index
    # authorize(Project)
    super
  end

  def create
    # authorize(Project)
    super
    if @project.save(project_params.except(:employees))
      render json: @project
    else
      render json: { message: "Error creating project." }
    end
  end

  def update
    # authorize(@project)
    super
    if @project.update(project_params.except(:employees))
      render json: @project
    else
      render json: { message: "Error updating project." }
    end
  end

  def destroy
    # authorize(@project)
    super
    render json: { message: "Deleted project." }
  end
end
