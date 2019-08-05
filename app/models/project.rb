# frozen_string_literal: true

class Project < ApplicationRecord
  mount_uploaders :files, FileUploader
  serialize :files, JSON # If you use SQLite, add this line.
  belongs_to :manager, class_name: 'User'
  belongs_to :client
  has_and_belongs_to_many :employees, join_table: 'employees_projects'
  has_many :payments
  has_many :time_logs
end
