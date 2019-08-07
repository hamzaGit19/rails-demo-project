# frozen_string_literal: true

class Employee::ProjectsController < ProjectsController
  def show
    super
    render 'projects/show', project: @project, _url: employee_project_path
  end
end
