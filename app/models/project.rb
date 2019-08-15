# frozen_string_literal: true

class Project < ApplicationRecord
  mount_uploaders :files, FileUploader

  serialize :files, JSON # If you use SQLite, add this line.

  belongs_to :manager, class_name: 'User'
  belongs_to :client

  has_and_belongs_to_many :employees, join_table: 'employees_projects', optional: true

  has_many :payments, dependent: :delete_all
  has_many :time_logs, dependent: :delete_all
  has_many :comments, as: :commentable, dependent: :delete_all

  validates :manager, presence: true
  validates :client, presence: true

  def self.apply_filters(params)
    if params[:role].eql? 'Admin'
      results = Project.where('name LIKE ?', "%#{params[:title]}%") if params[:title].present?
    elsif params[:role].eql? 'Manager'
      results = Project.where('name LIKE (?) AND manager_id=?', "%#{params[:title]}%", params[:user_id])
    elsif params[:role].eql? 'Employee'
      results = Project.includes(:employees).where(users: { id: params[:user_id] })
    end
    results
  end
end
