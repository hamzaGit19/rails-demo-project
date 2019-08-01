class Project < ApplicationRecord
    belongs_to :manager ,class_name: "User" 
    belongs_to :client
end
