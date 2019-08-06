# frozen_string_literal: true

module ProjectsHelper
  def options_for_managers
    @managers = Manager.all
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

  def get_user_name(id)
    @user = User.find(id)
    @user.name
  end

  def get_employees(id)
    employees = []

    Employee.joins(:projects).where(projects: { id: id }).find_each do |user|
      employees << user.name
    end
    employees
  end

  def get_time_url(current_user)
    if current_user.admin?
      _time_url = admin_project_time_logs_path(@project)
    elsif current_user.manager?
      _time_url = manager_project_time_logs_path(@project)
    else
      _time_url = employee_project_time_logs_path(@project)
    end
  end

  def get_payment_url(current_user)
    if current_user.admin?
      _payment_url = admin_project_payments_path(@project)
    elsif current_user.manager?
      _payment_url = manager_project_payments_path(@project)
    else
      _payment_url = ""
    end
  end
end
