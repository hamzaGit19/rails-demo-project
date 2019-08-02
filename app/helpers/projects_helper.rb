# frozen_string_literal: true

module ProjectsHelper
  def options_for_managers
    @managers = Manager.all
  end

  def get_manager_name(id)
    @manager = Manager.find(id)
    @manager.name
  end

  def get_clients
    @clients = Client.all
  end

  def get_client_name(id)
    @client = Client.find(id)
    @client.name
  end

  def get_company_name(id)
    @client = Client.find(id)
    @client.company
  end

  def get_creator_name(id)
    @user = User.find(id)
    @user.name
  end

  def get_employees(id)
    employees = []

    Employee.joins(:projects).where(projects: { id: id }).find_each do |user|
      employees << user.name
    end

    # Employee.where(projects[project_id]: id).find_each do |user|
    #   employees<< user.name
    # end
    employees
  end
end
