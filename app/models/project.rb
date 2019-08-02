class Project < ApplicationRecord
    belongs_to :manager, class_name: "User" 
    belongs_to :client
    has_and_belongs_to_many :employees, join_table: 'employees_projects'
end
