class Employe::ProjectPolicy < ApplicationPolicy
  
  def is_allowed?
    #only allowed if emp is working on that priject
end
