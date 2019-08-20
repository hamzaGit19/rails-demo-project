# frozen_string_literal: true

class TimeLog < ApplicationRecord
  attr_accessor :current_user

  paginates_per 5

  belongs_to :project
  has_many :comments, as: :commentable

  validates :project, presence: true
  validates :creator_id, presence: true
  validates :hours, presence: true, numericality: true
  validates :employee_id, presence: true
  validate :employee_exists
  validate :employee_on_project

  def employee_exists
    @employee = Employee.find_by_id(employee_id)
    errors.add(:employee_id, "This employee doesn't exist!") unless @employee
  end

  def employee_on_project
    @employee = Employee.find_by_id(employee_id)
    project_employees = project.employees
    if project_employees.nil?
      errors.add(:employee_id, "This employee doesn't work on this project!")
    else
      errors.add(:employee_id, "This employee doesn't work on this project!") unless project_employees.include?(@employee)
    end
  end
end
