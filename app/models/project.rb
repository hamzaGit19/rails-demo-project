# frozen_string_literal: true

class Project < ApplicationRecord
  mount_uploaders :files, FileUploader
  searchkick word_start: [:title, :description, :cost]
  paginates_per 7

  serialize :files, JSON # If you use SQLite, add this line.

  belongs_to :manager, class_name: "User"
  belongs_to :client

  has_and_belongs_to_many :employees, join_table: "employees_projects", optional: true

  has_many :payments, dependent: :delete_all
  has_many :time_logs, dependent: :delete_all
  has_many :comments, as: :commentable, dependent: :delete_all

  validates :manager, presence: true
  validates :client, presence: true

  def self.apply_filter(params, current_user)
    @projects = if current_user.employee?
                  current_user.projects
                else
                  Project.all # creates an anonymous scope
                end
    @projects = @projects.where("name like ?", "#{params[:title]}%") if params[:title].present?
    @projects
  end

  def add_employees(project_params)
    employee_ids = project_params[:employees]
    employee_ids.delete("")
    self.employees = Employee.find(employee_ids)
  end

  def search_data
    {
      title: title,
      description: description,
      cost: cost,
    }
  end
end
