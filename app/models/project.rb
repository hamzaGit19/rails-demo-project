# frozen_string_literal: true

class Project < ApplicationRecord
  mount_uploaders :files, FileUploader

  paginates_per 7

  serialize :files, JSON # If you use SQLite, add this line.

  belongs_to :manager, class_name: 'User'
  belongs_to :client

  has_and_belongs_to_many :employees, join_table: 'employees_projects', optional: true

  has_many :payments, dependent: :delete_all
  has_many :time_logs, dependent: :delete_all
  has_many :comments, as: :commentable, dependent: :delete_all

  validates :manager, presence: true
  validates :client, presence: true

  scope :project_title, ->(name) { where('name like ?', "#{name}%") }
  # def self.apply_filters(params)
  #   if params[:role].eql? "Admin"
  #     results = Project.where("name LIKE ?", "%#{params[:title]}%") if params[:title].present?
  #   elsif params[:role].eql? "Manager"
  #     results = Project.where("name LIKE (?) AND manager_id=?", "%#{params[:title]}%", params[:user_id])
  #   elsif params[:role].eql? "Employee"
  #     results = Project.includes(:employees).where(users: { id: params[:user_id] })
  #   end
  #   results
  # end

  def self.apply_filter(params, current_user)
    @projects = if current_user.employee?
                  current_user.projects
                else
                  Project.where(nil) # creates an anonymous scope
                end
    @projects = @projects.project_title(params[:title]) if params[:title].present?
    @projects
  end
end
