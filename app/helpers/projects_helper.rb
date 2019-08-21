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

  def total_payments(project)
    total = project.payments.sum(:amount)
  end

  def total_hours(project)
    total = project.time_logs.sum(:hours)
  end

  def get_time_url(current_user)
    _time_url = if current_user.admin?
                  admin_project_time_logs_path(@project)
                elsif current_user.manager?
                  manager_project_time_logs_path(@project)
                else
                  employee_project_time_logs_path(@project)
                end
  end

  def get_payment_url(current_user)
    _payment_url = if current_user.admin?
                     admin_project_payments_path(@project)
                   elsif current_user.manager?
                     manager_project_payments_path(@project)
                   else
                     ''
                   end
  end

  def get_top_projects
    Project.joins(:payments).limit(5).group(:name).sum(:amount)
  end

  def get_bottome_projects
    Project.joins(:payments).limit(5).group(:name).order('SUM(amount)').sum(:amount)
  end

  def get_top_employees
    Employee.where('time_logs.created_at > ?', Time.now - 7.days).joins('INNER JOIN time_logs ON users.id = time_logs.employee_id').limit(3).group(:name).sum(:hours)
  end

  def get_top_client
    Client.joins(:projects).limit(3).group(:name).count(:id)
  end
end
